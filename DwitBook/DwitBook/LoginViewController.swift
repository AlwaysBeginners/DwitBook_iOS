//  LoginViewController.swift
//  DwitBook

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        setButtonAppearance()
    }
    
    private func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .mainColor
        self.navigationItem.backButtonTitle = ""
    }
    
    private func setButtonAppearance() {
        loginButton.layer.cornerRadius = 10
        registerButton.setBorder(color: .mainColor, width: 1.5, radius: 10)
    }
    
    @IBAction func loginButtonClicked(_ sender: Any) {
        print(nicknameTextField.text, passwordTextField.text)
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        
    }
    
    
}
