//
//  TeacherFollowsViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

class TeacherFollowsViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var teacherFollowTableView: UITableView!
    
    var followMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarUI()
        callApiToGetFollowersInfo()
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let navigationBarLabel =  UILabel()
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.textAlignment = .center
        navigationBarLabel.text = "Followers"
        self.navigationItem.titleView = navigationBarLabel
        
        let navigationBarRightButton =  UIButton()
        navigationBarRightButton.setImage(UIImage(named: "settings"), for: .normal)
        navigationBarRightButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        navigationBarRightButton.addTarget(self, action: #selector(settingsButtonPressed(_:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = navigationBarRightButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func settingsButtonPressed(_ sender: UIBarButtonItem)
    {
        print("tapped")
        let settingsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsView") as! SettingsViewController
        self.navigationController!.pushViewController(settingsViewController, animated:true)
    }
    
    // MARK: - Api Calling
    
    func callApiToGetFollowersInfo()
    {
        EZLoadingActivity.show("Loading...", disableUI: false)
        let teacherID = UserDefaults.standard.string(forKey: URLConstants.UserDefaults.LoggedInTeacherID)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "teacher_id": teacherID!,
            ]
        performRequestToGetFollowersInfo(parameters: parameters)
    }
    
    func performRequestToGetFollowersInfo(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.GetAllFollows, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                print(cardJsonObject as Any)
                
                EZLoadingActivity.hide(true, animated: true)
                
                if (cardJsonObject?.value(forKey: "response")) != nil
                {
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        let followArray = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        
                        if result == "SUCCESS"
                        {
                            for object in followArray
                            {
                                let objectDict = object as! NSDictionary
                                let objectArray = objectDict.value(forKey: "StudentData") as! NSArray
                                let followDict = objectArray.object(at: 0) as! NSDictionary
                                
                                self.followMutableArray.add(followDict)
                            }
                            self.teacherFollowTableView.reloadData()
                        }
                        else
                        {
                            let alert = UIAlertController(title: "Request not processed succesfuly!", message: nil, preferredStyle: .alert) // 1
                            let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                            }
                            alert.addAction(firstAction)
                            self.present(alert, animated: true, completion:nil)
                        }
                    }
                    if self.followMutableArray.count == 0
                    {
                        let alert = UIAlertController(title: "You don't have any follower right now!", message: nil, preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Request not processed succesfuly!", message: "Please check your internet connection.", preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                    }
                    alert.addAction(firstAction)
                    self.present(alert, animated: true, completion:nil)
                }
            }
        }
    }
    
    // MARK: - Table View Delegate And Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.followMutableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let followCell = tableView.dequeueReusableCell(withIdentifier: "followCell", for: indexPath) as! FollowTableViewCell
        
        tableView.tableFooterView = UIView()
        
        let followDict = self.followMutableArray.object(at: indexPath.row) as! NSDictionary
        
        if let name = followDict.value(forKey: "name") as? String{
            followCell.nameLabel.text = name
        }
        
        followCell.profilePicImageView.layer.cornerRadius = followCell.profilePicImageView.frame.size.width/2
        followCell.profilePicImageView.clipsToBounds = true

        return followCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        editingIndexPath = indexPath as NSIndexPath
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
