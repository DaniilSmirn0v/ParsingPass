//
//  MainView.swift
//  ParsingPass
//
//  Created by Даниил Смирнов on 14.07.2022.
//


import UIKit

class MainView: UIView {
    //MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 40
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var currentPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Enter your password:>"
        textField.font = .systemFont(ofSize: 20, weight: .regular)
        textField.borderStyle = .roundedRect
        textField.isSecureTextEntry = true
        textField.clearButtonMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.minimumScaleFactor = 0.5
        label.adjustsFontSizeToFitWidth = true
        label.text = "Password: - "
        return label
    }()
    
    lazy var passwordActionButton: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .black
        button.setTitle("Start Parsing", for: .normal)
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var changeBackGroundColor: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Change BackGround Color", for: .normal)
        button.backgroundColor = .black
        button.tintColor = .white
        button.layer.cornerRadius = 15
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    //MARK: - Inititalize
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupHierarchy()
        setupLayout()
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Settings
    private func setupHierarchy() {
        addSubview(stackView)
        stackView.addArrangedSubview(activityIndicator)
        stackView.addArrangedSubview(currentPasswordTextField)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(passwordActionButton)
        stackView.addArrangedSubview(changeBackGroundColor)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            stackView.widthAnchor.constraint(equalToConstant: (window?.layer.bounds.width ?? 250) - 20 ),
            stackView.heightAnchor.constraint(equalToConstant: window?.layer.bounds.height ?? 350),
            stackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -50),
            stackView.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
}
