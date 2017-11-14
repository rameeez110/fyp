//
//  ViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/14/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var signupAlphaContainerView: UIView!
    @IBOutlet weak var signupContainerView: UIView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var teacherSignupButton: UIButton!
    @IBOutlet weak var studentSignupButton: UIButton!
    @IBOutlet weak var cancelSignupButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        setupNavBarUI()
        setupUI()
    }
    
    // MARK: - Nav Bar UI
    
    func setupNavBarUI()
    {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - View UI
    
    func setupUI()
    {
        self.loginButton.layer.cornerRadius = 15
        self.loginButton.clipsToBounds = true
        
        self.signupButton.layer.cornerRadius = 15
        self.signupButton.clipsToBounds = true
        
        self.teacherSignupButton.layer.cornerRadius = 10
        self.teacherSignupButton.clipsToBounds = true
        
        self.studentSignupButton.layer.cornerRadius = 10
        self.studentSignupButton.clipsToBounds = true
        
        self.cancelSignupButton.layer.cornerRadius = 15
        self.cancelSignupButton.clipsToBounds = true
        
        self.signupContainerView.layer.cornerRadius = 5
        self.signupContainerView.clipsToBounds = true
        
        self.usernameTextField.layer.cornerRadius = 5
        self.usernameTextField.clipsToBounds = true
        
        self.passwordTextField.layer.cornerRadius = 5
        self.passwordTextField.clipsToBounds = true
    }
    
    // MARK: - IBActions
    
    @IBAction func loginButtonPressed()
    {
        //callApiToLogin()
    }
    
    @IBAction func signupButtonPressed()
    {
        self.signupContainerView.isHidden = false
        self.signupAlphaContainerView.isHidden = false
    }
    
    @IBAction func signupCancelButtonPressed()
    {
        self.signupContainerView.isHidden = true
        self.signupAlphaContainerView.isHidden = true
    }
    
    @IBAction func forgetPasswordButtonPressed()
    {
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.isFirstResponder
        {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

