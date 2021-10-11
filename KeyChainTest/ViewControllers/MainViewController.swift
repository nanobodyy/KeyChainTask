//
//  MainViewController.swift
//  KeyChainTest
//
//  Created by Гурген on 11.10.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "logined"
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addConstraints()
        
        let notificationCenter = NotificationCenter.default
            notificationCenter.addObserver(self, selector: #selector(appMovedToBackground), name: UIApplication.willResignActiveNotification, object: nil)
        
    }
    
    func configureUI() {
        view.addSubview(titleLabel)
        
        view.backgroundColor = .white
    }
    
    func addConstraints() {
        titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    @objc func appMovedToBackground() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}
