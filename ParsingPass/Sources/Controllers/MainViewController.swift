//
//  MainViewController.swift
//  ParsingPass
//
//  Created by Даниил Смирнов on 14.07.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: - Initialize View
    private var mainView: MainView? {
        guard isViewLoaded else { return nil }
        return view as? MainView
    }
    
    //MARK: - Properties
    var isColor: Bool = false {
        didSet {
            if isColor {
                self.mainView!.backgroundColor = .lightGray
            } else {
                self.mainView!.backgroundColor = .red
            }
        }
    }
    
    var parsingIsActive = true

    //MARK: - LifeCycle
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSelectorForChangeBacgroudButton()
        addSelectorForParsingPasswordButton()
    }
    
    //MARK: - Methods for changeBacgroudColorButton
    private func addSelectorForChangeBacgroudButton() {
        mainView?.changeBackGroundColor.addTarget(self, action: #selector(onBut), for: .touchUpInside)
    }
    
    @objc func onBut() {
        DispatchQueue.main.async {
            self.isColor.toggle()
        }
    }
    
    //MARK: - Methods for parsingButton
    private func addSelectorForParsingPasswordButton() {
            mainView?.passwordActionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @objc func buttonTapped() {
        bruteForce(passwordToUnlock: mainView?.currentPasswordTextField.text ?? "error")
        parsingIsActive.toggle()
    }
    
    func bruteForce(passwordToUnlock: String) {
        let ALLOWED_CHARACTERS:   [String] = String().printable.map { String($0) }
        var password: String = ""
        
        let queue = DispatchQueue(label: "parsing", qos: .utility, attributes: .concurrent)
        queue.async {
            if self.parsingIsActive == false {
                while password != passwordToUnlock {
                    if self.parsingIsActive == false {
                        password = self.generateBruteForce(password, fromArray: ALLOWED_CHARACTERS)
                
                        DispatchQueue.main.sync {
                            self.mainView?.descriptionLabel.text = "Password: - \(password)"
                            self.mainView?.passwordActionButton.setTitle("Cancel Parsing", for: .normal)
                            self.mainView?.activityIndicator.startAnimating()
                            if password == passwordToUnlock {
                                self.mainView?.passwordActionButton.setTitle("Start Parsing", for: .normal)
                                self.mainView?.activityIndicator.stopAnimating()

                                self.parsingIsActive = true
                            }
                        }
                    } else {
                        break
                    }
                }
            } else {
                DispatchQueue.main.sync {
                    self.mainView?.passwordActionButton.setTitle("Start Parsing", for: .normal)
                    self.mainView?.descriptionLabel.text = "Password: - \(self.mainView?.currentPasswordTextField.text ?? "random") not hacked"
                    self.mainView?.activityIndicator.stopAnimating()
                }
            }
        }
    }
}

extension String {
    var digits:      String { return "0123456789" }
    var lowercase:   String { return "abcdefghijklmnopqrstuvwxyz" }
    var uppercase:   String { return "ABCDEFGHIJKLMNOPQRSTUVWXYZ" }
    var punctuation: String { return "!\"#$%&'()*+,-./:;<=>?@[\\]^_`{|}~" }
    var letters:     String { return lowercase + uppercase }
    var printable:   String { return digits + letters + punctuation }
    
    
    
    mutating func replace(at index: Int, with character: Character) {
        var stringArray = Array(self)
        stringArray[index] = character
        self = String(stringArray)
    }
}

extension MainViewController {
    func indexOf(character: Character, _ array: [String]) -> Int {
        return array.firstIndex(of: String(character))!
    }

    func characterAt(index: Int, _ array: [String]) -> Character {
        return index < array.count ? Character(array[index])
        : Character("")
    }

    func generateBruteForce(_ string: String, fromArray array: [String]) -> String {
        var str: String = string
        
        if str.count <= 0 {
            str.append(characterAt(index: 0, array))
        }
        else {
            str.replace(at: str.count - 1,
                        with: characterAt(index: (indexOf(character: str.last!, array) + 1) % array.count, array))
            
            if indexOf(character: str.last!, array) == 0 {
                str = String(generateBruteForce(String(str.dropLast()), fromArray: array)) + String(str.last!)
            }
        }
        
        return str
    }
}
