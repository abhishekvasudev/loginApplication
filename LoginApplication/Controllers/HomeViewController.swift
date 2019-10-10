//
//  HomeViewController.swift
//  LoginApplication
//
//  Created by Abhishek Vasudev on 09/10/19.
//  Copyright © 2019 Abhishek Vasudev. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func LogoutButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
