//
//  LoginViewController.swift
//  KeyChainTest
//
//  Created by Гурген on 11.10.2021.
//

import UIKit

class LoginViewController: UIViewController {
    
    var loginTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "login"
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "password"
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    var signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign In", for: .normal)
        button.setTitleColor(.green, for: .normal)
        button.layer.cornerRadius = 5
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var signUpButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        button.setTitleColor(.systemYellow, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var messageLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.isHidden = true
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstrains()
    }
    
    func configureUI() {
        view.addSubview(loginTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        view.addSubview(messageLabel)
        
        view.backgroundColor = .white
        
        signInButton.addTarget(self, action: #selector(signInDidTap), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpDidTap), for: .touchUpInside)
        
        title = "KeyChainTest"
    }
    
    func addConstrains() {
        
        passwordTextField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        loginTextField.bottomAnchor.constraint(equalTo: passwordTextField.topAnchor, constant: -10).isActive = true
        loginTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        loginTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        signInButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 30).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        signUpButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 10).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: -4).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    
    @objc func signInDidTap() {
        guard let login = loginTextField.text else { return }
        guard let passwordFromTextField = passwordTextField.text else { return }
        
        do {
            let password = try PasswordService.shared.keyChain.getString(login)
            
            if password == passwordFromTextField {
                let mainController = MainViewController()
                mainController.titleLabel.text = "\(login) logined"
                navigationController?.pushViewController(mainController, animated: true)
            } else {
                messageLabel.text = "incorrect password or login"
                messageLabel.isHidden = false
            }
            
        } catch {
            print(error)
        }
    }
    
    @objc func signUpDidTap() {
        guard let login = loginTextField.text else { return }
        guard let passwordFromTextField = passwordTextField.text else { return }
        
        if passwordFromTextField.count < 5 {
            messageLabel.text = "password is less than 6 characters"
            return
        }
        
        let checkPassword = try? PasswordService.shared.keyChain.get(login)
        messageLabel.text = "Already registered"
        messageLabel.isHidden = false
            
        if checkPassword == nil {
                
            do {
                try PasswordService.shared.keyChain.set(passwordFromTextField, key: login)
                messageLabel.text = "Registred"
                messageLabel.textColor = . green
                messageLabel.isHidden = false
            } catch {
                print(error)
            }
        }
    }
}
