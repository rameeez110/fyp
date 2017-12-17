//
//  ResetPasswordViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 12/17/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import Alamofire
import EZLoadingActivity

class ResetPasswordViewController: UIViewController , UITextFieldDelegate{
    
    @IBOutlet weak var oldPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarUI()
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let navigationBarLeftButton = UIButton()
        navigationBarLeftButton.setImage(UIImage(named: "left-arrow"), for: UIControlState())
        navigationBarLeftButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        navigationBarLeftButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = navigationBarLeftButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let navigationBarLabel =  UILabel()
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.text = "PASSWORD"
        self.navigationItem.titleView = navigationBarLabel
        
        let navigationBarRightButton = UIButton()
        navigationBarRightButton.setTitle("Done", for: .normal)
        navigationBarRightButton.setTitleColor(UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1), for: .normal)
        navigationBarRightButton.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
        navigationBarRightButton.addTarget(self, action: #selector(doneButtonPressed(_:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = navigationBarRightButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func doneButtonPressed(_ sender: UIBarButtonItem)
    {
        if self.oldPasswordTextField.text == "" || self.newPasswordTextField.text == ""
        {
            let alert = UIAlertController(title: "Fields can't be empty!", message: "Please enter old password and new password to proceed.", preferredStyle: .alert) // 1
            let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
            }
            alert.addAction(firstAction)
            self.present(alert, animated: true, completion:nil)
        }
        else
        {
            //Show Loader
            EZLoadingActivity.show("Loading ..", disableUI: false)
            callApiToResetPassword()
        }
    }
    
    // MARK: - Api Calling
    
    func callApiToResetPassword()
    {
        let userServerID = UserDefaults.standard.value(forKey: "LoggedInUserServerID")
        
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "userID": userServerID!,
            "oldPassword": self.oldPasswordTextField.text!,
            "newPassword": self.newPasswordTextField.text!,
            ]
        performRequestForResettingPawssword(parameters: parameters)
    }
    
    func performRequestForResettingPawssword(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.ChangePassword, parameters: parameters).responseData { response in
            if let data = response.data
            {
                EZLoadingActivity.hide(true, animated: true)
                
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                print(cardJsonObject as Any)
                
                let result = cardJsonObject?.value(forKey: "response") as! String
                let error = cardJsonObject?.value(forKey: "error") as! String
                
                if result == "NOT SUCCESS"
                {
                    let alert = UIAlertController(title: error, message: "Please enter old password correctly.", preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        _ = self.navigationController?.popViewController(animated: true)
                    }
                    alert.addAction(firstAction)
                    self.present(alert, animated: true, completion:nil)
                }
                else
                {
                    let alert = UIAlertController(title: "Password Updated!", message: nil, preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        _ = self.navigationController?.popViewController(animated: true)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
