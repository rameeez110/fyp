//
//  StudentTimeDetailViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 12/19/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

class StudentTimeDetailViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var timeTableContainerView: UIView!
    
    @IBOutlet weak var teacherTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
    public var teacherMutableArray = NSMutableArray()
//    public var timeMutableArray = NSMutableArray()
    var myCommitments = [TimeLocalModel]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigationBarUI()
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        
        let navigationBarLeftButton = UIButton()
        navigationBarLeftButton.setImage(UIImage(named: "left-arrow"), for: UIControlState())
        navigationBarLeftButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        navigationBarLeftButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = navigationBarLeftButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let navigationBarLabel =  UILabel()
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.text = "Teacher's Time"
        self.navigationItem.titleView = navigationBarLabel
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    // MARK: - IBActions
    
    @IBAction func doneButtonPressed()
    {
        self.alphaView.isHidden = true
        self.timeTableContainerView.isHidden = true
    }

    
    // MARK: - Api Calling
    
    func callApiToGetTimeTeacherWise(id: Int)
    {
        EZLoadingActivity.show("Loading...", disableUI: false)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "teacher_id": String(id),
            ]
        performRequestToGetTeachers(parameters: parameters)
    }
    
    func performRequestToGetTeachers(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.GetTimeTeacherWise, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
//                print(cardJsonObject as Any)
                
                EZLoadingActivity.hide(true, animated: true)
                if (cardJsonObject?.value(forKey: "data")) != nil
                {
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        let timeArray = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        
                        if result == "SUCCESS"
                        {
                            
                            for time in timeArray
                            {
                                let timeDict = time as! NSDictionary
                                let timeModel = self.parseDataModel(timeDict: timeDict)
                                
//                                self.timeMutableArray.add(timeModel)
                            }
                            
                            if self.myCommitments.count > 0
                            {
                                self.alphaView.isHidden = false
                                self.timeTableContainerView.isHidden = false
                                self.timeTableView.reloadData()
                            }
                            else
                            {
                                let alert = UIAlertController(title: "No commitments found!", message: nil, preferredStyle: .alert) // 1
                                let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                                }
                                alert.addAction(firstAction)
                                self.present(alert, animated: true, completion:nil)
                            }
                        }
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Request not processed!", message: "Please check your internet connection", preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                    }
                    alert.addAction(firstAction)
                    self.present(alert, animated: true, completion:nil)
                }
            }
        }
    }
    
    func parseDataModel(timeDict: NSDictionary) -> Time
    {
        let timeModel = Time()
        
        let id = timeDict["id"] as! String
        timeModel.id = Int(id)!
        
        if let day = timeDict["day"] as? String{
            timeModel.day = day
        }
        
        if let isMorning = timeDict["is_morning"] as? String{
            timeModel.isMorning = isMorning
        }
        
        if let meta = timeDict["meta"] as? String{
            timeModel.meta = meta
        }
        
        if let timeStatus = timeDict["status"] as? String{
            timeModel.status = timeStatus
        }
        
        if let program = timeDict["program"] as? String{
            timeModel.program = program
        }
        
        if let section = timeDict["section"] as? String{
            timeModel.section = section
        }
        
        if let semester = timeDict["semester"] as? String{
            timeModel.semester = semester
        }
        
        if let timeDuration = timeDict["time_duration"] as? String{
            timeModel.time_duration = timeDuration
        }
        
        if let teacherID = timeDict["teacher_id"] as? String{
            timeModel.teacherID = teacherID
        }
        
        if let courseID = timeDict["course_id"] as? String{
            timeModel.courseID = courseID
        }
        
        if let courseData = timeDict["CourseData"] as? NSArray{
            let courseDict = courseData.object(at: 0) as! NSDictionary
            let courseModel = Course()
            
            let id = courseDict["id"] as! String
            courseModel.id = Int(id)!
            
            if let code = courseDict["code"] as? String{
                courseModel.code = code
            }
            
            if let creditHours = courseDict["credit_hours"] as? String{
                courseModel.credit_hours = creditHours
            }
            
            if let meta = courseDict["meta"] as? String{
                courseModel.meta = meta
            }
            
            if let courseStatus = courseDict["status"] as? String{
                courseModel.status = courseStatus
            }
            
            if let program = courseDict["program"] as? String{
                courseModel.program = program
            }
            
            if let number = courseDict["number"] as? String{
                courseModel.number = number
            }
            
            if let semester = courseDict["semester"] as? String{
                courseModel.semester = semester
            }
            
            if let name = courseDict["name"] as? String{
                courseModel.name = name
            }
            
            if let server_id = courseDict["server_id"] as? String{
                courseModel.server_id = server_id
            }
            
            timeModel.courseData = courseModel
        }
        
        if let teacherData = timeDict["TeacherData"] as? NSArray{
            let teacherDict = teacherData.object(at: 0) as! NSDictionary
            let teacherModel = Teacher()
            
            let id = teacherDict["id"] as! String
            teacherModel.id = Int(id)!
            
            if let profile_pic = teacherDict["profile_pic"] as? String{
                teacherModel.profilePicName = profile_pic
            }
            
            if let availablity = teacherDict["availablity"] as? String{
                teacherModel.availablity = availablity
            }
            
            if let name = teacherDict["name"] as? String{
                teacherModel.name = name
            }
            
            if let meta = teacherDict["meta"] as? String{
                teacherModel.meta = meta
            }
            
            if let teacherStatus = teacherDict["status"] as? String{
                teacherModel.status = teacherStatus
            }
            
            if let qualification = teacherDict["qualification"] as? String{
                teacherModel.qualification = qualification
            }
            
            timeModel.teacherData = teacherModel
        }
        
        return timeModel
    }
    
    // MARK: - Table View Delegate And Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.teacherTableView
        {
            return self.teacherMutableArray.count
        }
        else
        {
            return self.myCommitments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.tableFooterView = UIView()
        if tableView == self.teacherTableView
        {
            let followCell = tableView.dequeueReusableCell(withIdentifier: "followCell", for: indexPath) as! FollowTableViewCell
            
            let teacherModel = self.teacherMutableArray.object(at: indexPath.row) as! Teacher
            
            followCell.followButton.isHidden = true
            
            followCell.nameLabel.text = teacherModel.name
            
            return followCell
        }
        else
        {
            let timeCell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeTableViewCell
            
            let timeModel = self.myCommitments[indexPath.row]
            let teacherModel = timeModel.teacherData
            let courseModel = timeModel.courseData
            
            timeCell.teacherValueLabel.text = teacherModel.name
            timeCell.courseValueLabel.text = courseModel.name
            timeCell.timeValueLabel.text = timeModel.time_duration
//            timeCell.locationValueLabel.text = "FF 07"
            timeCell.dayValueLabel.text = timeModel.day
            timeCell.sectionValueLabel.text = timeModel.section
            
            let isTheory = timeModel.isTheory
            if isTheory == "Yes"
            {
                if timeModel.semester == Semester.Seventh.rawValue || timeModel.semester == Semester.Eighth.rawValue
                {
                    if timeModel.program == Program.BSCS.rawValue{
                        if timeModel.section == Section.SectionA.rawValue{
                            timeCell.locationValueLabel.text = "GF 22"
                        }
                        else{
                            timeCell.locationValueLabel.text = "GF 23"
                        }
                    }
                    else{
                        if timeModel.section == Section.SectionA.rawValue{
                            timeCell.locationValueLabel.text = "GF 16"
                        }
                        else{
                            timeCell.locationValueLabel.text = "GF 17"
                        }
                    }
                }
                else if timeModel.semester == Semester.Fifth.rawValue || timeModel.semester == Semester.Sixth.rawValue
                {
                    if timeModel.program == Program.BSCS.rawValue{
                        if timeModel.section == Section.SectionA.rawValue{
                            timeCell.locationValueLabel.text = "FF 22"
                        }
                        else{
                            timeCell.locationValueLabel.text = "FF 23"
                        }
                    }
                    else{
                        if timeModel.section == Section.SectionA.rawValue{
                            timeCell.locationValueLabel.text = "FF 16"
                        }
                        else{
                            timeCell.locationValueLabel.text = "FF 17"
                        }
                    }
                }
                else{
                    timeCell.locationValueLabel.text = "SF 16"
                }
            }
            else
            {
                if timeModel.semester == Semester.Seventh.rawValue || timeModel.semester == Semester.Eighth.rawValue
                {
                    if timeModel.program == Program.BSCS.rawValue{
                        if timeModel.section == Section.SectionA.rawValue{
                            timeCell.locationValueLabel.text = "FF 01"
                        }
                        else{
                            timeCell.locationValueLabel.text = "FF 02"
                        }
                    }
                    else{
                        if timeModel.section == Section.SectionA.rawValue{
                            timeCell.locationValueLabel.text = "GF 03"
                        }
                        else{
                            timeCell.locationValueLabel.text = "GF 04"
                        }
                    }
                }
                else if timeModel.semester == Semester.Fifth.rawValue || timeModel.semester == Semester.Sixth.rawValue
                {
                    if timeModel.program == Program.BSCS.rawValue{
                        if timeModel.section == Section.SectionA.rawValue{
                            timeCell.locationValueLabel.text = "FF 07"
                        }
                        else{
                            timeCell.locationValueLabel.text = "FF 08"
                        }
                    }
                    else{
                        if timeModel.section == Section.SectionA.rawValue{
                            timeCell.locationValueLabel.text = "GF 09"
                        }
                        else{
                            timeCell.locationValueLabel.text = "GF 10"
                        }
                    }
                }
                else{
                    timeCell.locationValueLabel.text = "FF 11"
                }
            }
            
            return timeCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == self.teacherTableView
        {
            return 85
        }
        else
        {
            return 150
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == self.teacherTableView
        {
            let teacherModel = self.teacherMutableArray.object(at: indexPath.row) as! Teacher
//            callApiToGetTimeTeacherWise(id: teacherModel.id)
            myCommitments = DataBaseUtility.sharedInstance.getTimeTable(teacherId: String(teacherModel.id))
            if self.myCommitments.count > 0
            {
                self.alphaView.isHidden = false
                self.timeTableContainerView.isHidden = false
                self.timeTableView.reloadData()
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
