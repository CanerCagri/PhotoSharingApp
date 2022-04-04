//
//  ViewController.swift
//  PhotoSharingApp
//
//  Created by Caner Çağrı on 1.04.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func loginBtnTapped(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            //Login settings
            Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Please try again")
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
                
            
                
            }
        }
    }
    
    @IBAction func signupBtnTapped(_ sender: Any) {
        if emailTextField.text != "" && passwordTextField.text != "" {
            //Signup settings
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { authDataResult, error in
                if error != nil {
                    self.errorMessage(titleInput: "Error", messageInput: error?.localizedDescription ?? "Please try again")
                } else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
            //Error messages
            errorMessage(titleInput: "Error", messageInput: "Please enter an email and password")
        }
    }
    
    func errorMessage(titleInput: String , messageInput : String) {
        let ac = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(ac, animated: true)
    }
    
}

