//  RegisterViewController.swift
//  DwitBook

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var nicknameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordCheckTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAppearance()
    }
    
    
    
    private func setButtonAppearance() {
        registerButton.layer.cornerRadius = 10
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        
    }
}
