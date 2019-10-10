//
//  LoginViewController.swift
//  LoginApplication
//
//  Created by Abhishek Vasudev on 09/10/19.
//  Copyright © 2019 Abhishek Vasudev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private var viewModel: LoginViewModel!
    var url = AppURL.login
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //MARK:- End enditing when tapping anywhere
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK:- Login button action
    @IBAction func loginButtonCLicked(_ sender: Any) {
        resignTextFields()
        guard let userName = userNameTextField.text else {
            return
        }
        guard let password = passwordTextField.text else {
            return
        }
        
        // Uncomment below line to make API call for check the user details
        //getUser(userName:userName,password:password)
        
        //Below code is for demo purpose
        if userName == "abc" && password == "abc" {
            navigate()
        } else {
            showAlert(title: "Login Error", message: "Something went wrong!")
        }
        
        clearTextFields()
        
    }
    
    //MARK:- API CALL
    func getUser(userName:String,password:String){
        
        let loginURL = url.rawValue + "username=\(userName)+password=\(password)"
        viewModel = LoginViewModel(loginURL, self)
        viewModel.getUser()
    }
    
    //MARK:- Navigation method
    func navigate(){
        performSegue(withIdentifier: SegueId.login.rawValue, sender: self)
    }

}

// MARK: - Display alert
extension LoginViewController: AlertDisplayer {
    func showAlert(title: String, message: String){
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: message, actions: [action])
    }
}

//MARK:- TextField operations
extension LoginViewController {
    func resignTextFields(){
        userNameTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
    }
    
    func clearTextFields(){
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
}

//MARK:- LoginViewModelDelegate operations
extension LoginViewController: LoginViewModelDelegate {
    func onFetchCompleted(_ success: Bool) {
        navigate()
    }
    
    func onFetchFailed(_ error: Error) {
        showAlert(title: "Login Error", message: "Something went wrong!")
    }
    
    
}
