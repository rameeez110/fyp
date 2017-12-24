//
//  StudentFollowViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

class StudentFollowViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var studentFollowTableView: UITableView!
    
    var followMutableArray = NSMutableArray()
    
    var selectedFollowIndex = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarUI()
        callApiToGetTeachers()
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
        navigationBarLabel.text = "Follow"
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
        let settingsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "settingsView") as! SettingsViewController
        self.navigationController!.pushViewController(settingsViewController, animated:true)
    }
    
    // MARK: - Api Calling
    
    func callApiToGetTeachers()
    {
        EZLoadingActivity.show("Loading...", disableUI: false)
        let studentID = UserDefaults.standard.string(forKey: URLConstants.UserDefaults.LoggedInStudentID)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "student_id": studentID!,
            ]
        performRequestToGetTeachers(parameters: parameters)
    }
    
    func performRequestToGetTeachers(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.GetAllTeacherFollowsData, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
//                print(cardJsonObject as Any)
                
                EZLoadingActivity.hide(true, animated: true)
                
                if (cardJsonObject?.value(forKey: "data")) != nil
                {
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        let teachersDict = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        
                        if result == "SUCCESS"
                        {
                            for object in teachersDict
                            {
                                let teacherDict = object as! NSDictionary
                                let teacherModel = Teacher()
                                
                                let id = teacherDict["id"] as! String
                                teacherModel.id = Int(id)!

                                if let teacherPicName = teacherDict["profile_pic"] as? String{
                                    teacherModel.profilePicName = teacherPicName
                                }
                                
                                if let teacherQualification = teacherDict["qualification"] as? String{
                                    teacherModel.qualification = teacherQualification
                                }
                                
                                if let teacherName = teacherDict["name"] as? String{
                                    teacherModel.name = teacherName
                                }
                                
                                if let teacherStatus = teacherDict["status"] as? String{
                                    teacherModel.status = teacherStatus
                                }
                                
                                if let teacherAvailablity = teacherDict["availablity"] as? String{
                                    teacherModel.availablity = teacherAvailablity
                                }
                                
                                if let teacherUserID = teacherDict["user_id"] as? String{
                                    teacherModel.userID = teacherUserID
                                }
                                
                                if let teacherMeta = teacherDict["meta"] as? String{
                                    teacherModel.meta = teacherMeta
                                }
                                
                                if let followStatus = teacherDict["TeacherData"] as? String{
                                    teacherModel.followStatus = followStatus
                                }
                                
                                self.followMutableArray.add(teacherModel)
                            }
                            self.studentFollowTableView.reloadData()
                        }
                    }
                    if self.followMutableArray.count == 0
                    {
                        let alert = UIAlertController(title: "We don't have any teacher right now to follow!", message: nil, preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
                }
            }
        }
    }
    
    func callApiToAddFollow(teacherID: String , studentID: String)
    {
        EZLoadingActivity.show("Adding follower...", disableUI: false)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "teacher_id": teacherID,
            "student_id": studentID,
            ]
        performRequestToAddFollow(parameters: parameters)
    }
    
    func performRequestToAddFollow(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.AddFollow, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                print(cardJsonObject as Any)
                
                EZLoadingActivity.hide(true, animated: true)
                
                if let response = cardJsonObject?.value(forKey: "response")
                {
                    let result = response as! String
                    if result == "SUCCESS"
                    {
                        let model = self.followMutableArray.object(at: self.selectedFollowIndex) as! Teacher
                        model.followStatus = "Followed"
                        self.followMutableArray.replaceObject(at: self.selectedFollowIndex, with: model)
                        self.studentFollowTableView.reloadRows(at: [IndexPath (row: self.selectedFollowIndex, section: 0)], with: .none)
                        let alert = UIAlertController(title: "Followed!", message: nil, preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Can't follow at this time!", message: "Something went wrong please try again later or check your internet connection.", preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
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
        
        let teacherModel = self.followMutableArray.object(at: indexPath.row) as! Teacher
        
        followCell.followButton.layer.cornerRadius = 10
        followCell.followButton.clipsToBounds = true
        
        followCell.profilePicImageView.layer.cornerRadius = followCell.profilePicImageView.frame.size.width/2
        followCell.profilePicImageView.clipsToBounds = true
        
        let followStatus = teacherModel.followStatus
        if followStatus == "Followed"
        {
            followCell.followButton.isUserInteractionEnabled = false
            followCell.followButton.setTitle(followStatus, for: .normal)
            followCell.followButton.backgroundColor = UIColor(red: 62/255, green: 64/255, blue: 65/255, alpha: 1)
        }
        else
        {
            followCell.followButton.isUserInteractionEnabled = true
            followCell.followButton.setTitle(followStatus, for: .normal)
            followCell.followButton.backgroundColor = UIColor(red: 0/255, green: 213/255, blue: 243/255, alpha: 1)
        }
        
        
        followCell.nameLabel.text = teacherModel.name
        followCell.followButton.tag = indexPath.row
        followCell.followButton.addTarget(self, action: #selector(followButtonPressed(sender:)), for: .touchUpInside)
        
        return followCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    @objc func followButtonPressed(sender: UIButton) {
        let teacherModel = self.followMutableArray.object(at: sender.tag) as! Teacher
        
        let teacherID = String(teacherModel.id)
        if let studentID = UserDefaults.standard.string(forKey: URLConstants.UserDefaults.LoggedInStudentID)
        {
            selectedFollowIndex = sender.tag
            callApiToAddFollow(teacherID: teacherID, studentID: studentID)
        }
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
