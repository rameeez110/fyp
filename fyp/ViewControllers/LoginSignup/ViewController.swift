//
//  ViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/14/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

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
        callApiToLogin()
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
    
    // MARK: - Api Calling
    
    func callApiToLogin()
    {
        EZLoadingActivity.show("Loading...", disableUI: false)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "email": self.usernameTextField.text!,
            "password": self.passwordTextField.text!,
            ]
        performRequestToLogin(parameters: parameters)
    }
    
    func performRequestToLogin(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.UserLogin, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
//                print(cardJsonObject as Any)
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                EZLoadingActivity.hide(true, animated: true)
                if (cardJsonObject?.value(forKey: "data")) != nil
                {
                    var roleID = String()
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        let result = cardJsonObject?.value(forKey: "response") as! String

                        if result == "SUCCESS"
                        {
                            let dict = dataDict as! NSDictionary
//                            print(dict as Any)
                            let userModel = User()
                            userModel.createdAt = dict.value(forKey: "created_at") as! String
                            userModel.updatedAt = dict.value(forKey: "updated_at") as! String
                            userModel.id = dict.value(forKey: "user_id") as! Int
                            userModel.email = dict.value(forKey: "user_email") as! String
                            userModel.password = dict.value(forKey: "user_password") as! String
                            let roleIDInt = dict.value(forKey: "user_role_id") as! Int
                            userModel.roleID = String(roleIDInt)
                            roleID = userModel.roleID
                            
                            UserDefaults.standard.set(userModel.id, forKey: URLConstants.UserDefaults.LoggedInUserId)
                            UserDefaults.standard.set(userModel.roleID, forKey: URLConstants.UserDefaults.LoggedInUserRoleId)
                            UserDefaults.standard.set(userModel.email, forKey: URLConstants.UserDefaults.LoggedInUserEmail)
                            UserDefaults.standard.synchronize()
                        }
                    }
                    if (cardJsonObject?.value(forKey: "description")) != nil
                    {
                        if let descriptionDict = cardJsonObject?.value(forKey: "description")
                        {
                            let result = cardJsonObject?.value(forKey: "response") as! String
                            
                            if result == "SUCCESS"
                            {
                                let dict = descriptionDict as! NSDictionary
                                if roleID == "1"{
                                    
                                }
                                else if roleID == "2"{
                                    let teacherDict = dict.value(forKey: "TeacherData") as! NSDictionary
                                    print(teacherDict as Any)
                                    let teacherModel = Teacher()
                                    
                                    if let teacherPicName = teacherDict["profile_pic"] as? String{
                                        teacherModel.profilePicName = teacherPicName
                                        UserDefaults.standard.set(teacherModel.profilePicName, forKey: URLConstants.UserDefaults.LoggedInTeacherPicName)
                                    }
                                    
                                    teacherModel.name = teacherDict.value(forKey: "name") as! String
                                    teacherModel.id = teacherDict.value(forKey: "id") as! Int
                                    
                                    UserDefaults.standard.set(String(teacherModel.id), forKey: URLConstants.UserDefaults.LoggedInTeacherID)
                                    UserDefaults.standard.set(teacherModel.id, forKey: URLConstants.UserDefaults.LoggedInTeacherName)
                                    UserDefaults.standard.synchronize()
                                    
                                    let tabBarController: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TeacherTabBarController") as! UITabBarController
                                    self.navigationController?.pushViewController(tabBarController, animated: true)
                                }
                                else if roleID == "3"{
                                    let studentDict = dict.value(forKey: "StudentData") as! NSDictionary
                                    print(studentDict as Any)
                                    let studentModel = Student()
                                    
                                    if let studentPicName = studentDict["profile_pic"] as? String{
                                        studentModel.profilePicName = studentPicName
                                        UserDefaults.standard.set(studentModel.profilePicName, forKey: URLConstants.UserDefaults.LoggedInStudentPicName)
                                    }
                                    
                                    studentModel.name = studentDict.value(forKey: "name") as! String
                                    studentModel.id = studentDict.value(forKey: "id") as! Int
                                    
                                    UserDefaults.standard.set(String(studentModel.id), forKey: URLConstants.UserDefaults.LoggedInStudentID)
                                    UserDefaults.standard.set(studentModel.id, forKey: URLConstants.UserDefaults.LoggedInStudentName)
                                    UserDefaults.standard.synchronize()
                                    
                                    let tabBarController: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "StudentTabBarController") as! UITabBarController
                                    self.navigationController?.pushViewController(tabBarController, animated: true)
                                }
                            }
                        }
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Login Failed!", message: "Please check your internet connection or insert correct credentials.", preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                    }
                    alert.addAction(firstAction)
                    self.present(alert, animated: true, completion:nil)
                }
            }
        }
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

