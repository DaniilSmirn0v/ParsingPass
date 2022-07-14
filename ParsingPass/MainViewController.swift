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
    
    
    //MARK: - LifeCycle
    override func loadView() {
        self.view = MainView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

