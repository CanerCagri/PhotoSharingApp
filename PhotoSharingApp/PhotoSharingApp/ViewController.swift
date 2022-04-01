//
//  ViewController.swift
//  PhotoSharingApp
//
//  Created by Caner Çağrı on 1.04.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func loginBtnTapped(_ sender: Any) {
    }
    @IBAction func signupBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "toFeedVC", sender: nil)
    }
    
}

