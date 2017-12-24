//
//  StudentTimeViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

class StudentTimeViewController: UIViewController {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigationBarUI()
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        let navigationBarLabel =  UILabel()
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.textAlignment = .center
        navigationBarLabel.text = "Time Table"
        self.navigationItem.titleView = navigationBarLabel
    }
    
    // MARK: - IBactions
    
    @IBAction func teachersTimeButtonPressed()
    {
        callApiToGetTeachers()
    }
    
    @IBAction func fullTimeTableButtonPressed()
    {
        let showTimeTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showTimeTableView") as! ShowTimeTableViewController
        self.navigationController!.pushViewController(showTimeTableViewController, animated:true)
    }
    
    @IBAction func courseTimeButtonPressed(){
        appDelegate.isComingFromStudentCourseViewController = true
        let showCoursesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showCourses") as! ShowCoursesViewController
        self.navigationController!.pushViewController(showCoursesViewController, animated:true)
    }
    
    // MARK: - Api Calling
    
    func callApiToGetTeachers()
    {
        EZLoadingActivity.show("Loading...", disableUI: false)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            ]
        performRequestToGetTeachers(parameters: parameters)
    }
    
    func performRequestToGetTeachers(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.GetAllTeacher, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                EZLoadingActivity.hide(true, animated: true)
                if (cardJsonObject?.value(forKey: "data")) != nil
                {
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        let teachersDict = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        
                        if result == "SUCCESS"
                        {
                            let teacherMutableArray = NSMutableArray()
                            
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
                                
                                teacherMutableArray.add(teacherModel)
                            }
                            if teacherMutableArray.count == 0{
                                
                            }
                            else{
                                let studentTimeDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "studentTimeDetailView") as! StudentTimeDetailViewController
                                
                                    studentTimeDetailViewController.teacherMutableArray = NSMutableArray()
                                    studentTimeDetailViewController.teacherMutableArray = teacherMutableArray
                                self.navigationController!.pushViewController(studentTimeDetailViewController, animated:true)
                            }
                            //studentTimeDetailView
                        }
                    }
                }
            }
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
