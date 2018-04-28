//
//  MainViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import Alamofire
import EZLoadingActivity

class MainViewController: UIViewController {
    
    @IBOutlet weak var createTimeTableButton: UIButton!
    @IBOutlet weak var showCourseButton: UIButton!
    @IBOutlet weak var showTimeTableButton: UIButton!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadAllCourses()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBarUI()
    }
    
    func loadAllCourses()
    {
        let status = DataBaseUtility.sharedInstance.isCourseExisted()
        if status{
            print("course exists")
            loadAllTeachers()
        }
        else
        {
            EZLoadingActivity.show("Loading...", disableUI: false)
            callApiToGetAllCourse()
        }
    }
    
    func loadAllTeachers()
    {
        let status = DataBaseUtility.sharedInstance.isTeacherExisted()
        if status{
            print("teacher exists")
        }
        else
        {
            EZLoadingActivity.show("Loading...", disableUI: false)
            callApiToGetTeachers()
        }
    }
    
    func setupUI()
    {
        self.createTimeTableButton.layer.cornerRadius = 5
        self.createTimeTableButton.clipsToBounds = true
        
        self.showCourseButton.layer.cornerRadius = 5
        self.showCourseButton.clipsToBounds = true
    
        self.showTimeTableButton.layer.cornerRadius = 5
        self.showTimeTableButton.clipsToBounds = true
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
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
    
    @IBAction func createTimeTableButtonPressed()
    {
//        let createTimeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createTimeView") as! CreateTimeViewController
//        self.navigationController!.pushViewController(createTimeViewController, animated:true)
        let createTimeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "newCreateTimeView") as! NewCreateTimeViewController
        self.navigationController!.pushViewController(createTimeViewController, animated:true)
    }
    
    @IBAction func showCourseButtonPressed()
    {
        appDelegate.isComingFromStudentCourseViewController = false
        let showCoursesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showCourses") as! ShowCoursesViewController
        self.navigationController!.pushViewController(showCoursesViewController, animated:true)
    }
    
    @IBAction func showTimeTableButtonPressed()
    {
        let showTimeTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showTimeTableView") as! ShowTimeTableViewController
        self.navigationController!.pushViewController(showTimeTableViewController, animated:true)
    }
    
    // MARK: - Api Calling
    
    func callApiToGetAllCourse()
    {
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            ]
        performRequestToGetAllCourse(parameters: parameters)
    }
    
    func performRequestToGetAllCourse(parameters: Parameters)
    {
        Alamofire.request("https://rameeez110.000webhostapp.com/fyp/web/index.php/webservice/getallcourse/", parameters: parameters).responseData { response in
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
//                EZLoadingActivity.hide(true, animated: true)
//                print(cardJsonObject as Any)
                
                if cardJsonObject != nil{
                    
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        let coversDict = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        
                        if result == "SUCCESS"
                        {
                            for object in coversDict
                            {
                                let course = object as! NSDictionary
                                let courseModel = Course()
                                courseModel.name = course.value(forKey: "name") as! String
                                courseModel.number = course.value(forKey: "number") as! String
                                courseModel.program = course.value(forKey: "program") as! String
                                courseModel.code = course.value(forKey: "code") as! String
                                courseModel.meta = course.value(forKey: "meta") as! String
                                courseModel.semester = course.value(forKey: "semester") as! String
                                courseModel.status = course.value(forKey: "status") as! String
                                courseModel.credit_hours = course.value(forKey: "credit_hours") as! String
                                courseModel.server_id = course.value(forKey: "id") as! String
                                
                                DataBaseUtility.sharedInstance.createCourse(courseModel: courseModel)
                            }
                        }
                    }
                    else
                    {
                        let alert = UIAlertController(title: "No courses found!", message: nil, preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "No internet Connection!", message: "Please check your internet connection.", preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                    }
                    alert.addAction(firstAction)
                    self.present(alert, animated: true, completion:nil)
                }
            }
            self.loadAllTeachers()
        }
    }
    
    func callApiToGetTeachers()
    {
//        EZLoadingActivity.show("Loading...", disableUI: false)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            ]
        performRequestToGetTeachers(parameters: parameters)
    }
    
    func performRequestToGetTeachers(parameters: Parameters)
    {
        //        Alamofire.request("https://rameeez110.000webhostapp.com/fyp/web/index.php/webservice/getallteachers/", parameters: parameters).responseData { response in
        Alamofire.request(URLConstants.APPURL.GetAllTeacher, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                //                print(cardJsonObject as Any)
                EZLoadingActivity.hide(true, animated: true)
                if (cardJsonObject?.value(forKey: "data")) != nil
                {
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        //                        print(dataDict as Any)
                        let teachersDict = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        
                        if result == "SUCCESS"
                        {
                            for object in teachersDict
                            {
                                let teacher = object as! NSDictionary
                                let teacherModel = TeacherLocalModel()
                                teacherModel.availablity = teacher.value(forKey: "availablity") as! String
                                teacherModel.serverID = teacher.value(forKey: "id") as! String
                                teacherModel.name = teacher.value(forKey: "name") as! String
                                if let profilePic = teacher.value(forKey: "profile_pic") as? String{
                                    teacherModel.profilePicName = profilePic
                                }
                                teacherModel.status = teacher.value(forKey: "status") as! String
                                teacherModel.userID = teacher.value(forKey: "user_id") as! String
                                let quliification = teacher.value(forKey: "qualification") as! String
                                if quliification == "Masters"{
                                    teacherModel.qualification = Qualification.Masters.rawValue
                                }
                                else if quliification == "Phd"{
                                    teacherModel.qualification = Qualification.Phd.rawValue
                                }
                                else if quliification == "MPhil"{
                                    teacherModel.qualification = Qualification.MPhil.rawValue
                                }
                                else if quliification == "Hod"{
                                    teacherModel.qualification = Qualification.Hod.rawValue
                                }
                                else{
                                    teacherModel.qualification = Qualification.Bachelors.rawValue
                                }
                                
                                DataBaseUtility.sharedInstance.createTeacher(teacherModel: teacherModel)
                            }
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

enum Qualification: Int{
    case Bachelors = 0 , MPhil , Masters , Phd , Hod
}
