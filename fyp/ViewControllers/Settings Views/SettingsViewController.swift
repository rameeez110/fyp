//
//  SettingsViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 12/17/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

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
        navigationBarLabel.textAlignment = .center
        navigationBarLabel.text = "Settings"
        self.navigationItem.titleView = navigationBarLabel
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBActions
    
    @IBAction func resetPasswordButtonPressed()
    {
        let resetPasswordViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "resetPassword") as! ResetPasswordViewController
        self.navigationController!.pushViewController(resetPasswordViewController, animated:true)
    }
    
    @IBAction func logoutButtonPressed()
    {
        UserDefaults.standard.set("", forKey: URLConstants.UserDefaults.LoggedInUserEmail)
        UserDefaults.standard.set("", forKey: URLConstants.UserDefaults.LoggedInUserRoleId)
        UserDefaults.standard.set("", forKey: URLConstants.UserDefaults.LoggedInUserPassword)
        UserDefaults.standard.set("", forKey: URLConstants.UserDefaults.LoggedInUserId)
        
        UserDefaults.standard.synchronize()
        
        self.navigationController?.viewControllers.removeAll()
        
        
        let rootNavigationController = UINavigationController()
        rootNavigationController.navigationBar.barTintColor = UIColor(red: 0/255, green: 25/255, blue: 43/255, alpha: 1)
        let signInViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "loginView") as! ViewController
        appDelegate.window!.rootViewController = rootNavigationController
        rootNavigationController.pushViewController(signInViewController, animated: true)
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
