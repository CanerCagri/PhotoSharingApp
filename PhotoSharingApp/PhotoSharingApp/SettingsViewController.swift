//
//  SettingsViewController.swift
//  PhotoSharingApp
//
//  Created by Caner Çağrı on 1.04.2022.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func logoutBtnTapped(_ sender: Any) {
        performSegue(withIdentifier: "toVC", sender: nil)
    }
    
}
