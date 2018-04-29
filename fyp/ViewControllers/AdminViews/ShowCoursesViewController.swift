//
//  ShowCoursesViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

class ShowCoursesViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource ,UIPickerViewDelegate , UIPickerViewDataSource{
    
    @IBOutlet weak var pickerContainerView: UIView!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var timeTableContainerView: UIView!
    
    @IBOutlet weak var buttonContainerStackView: UIStackView!
    
    @IBOutlet weak var courseTableView: UITableView!
    @IBOutlet weak var timeTableView: UITableView!
    
    @IBOutlet weak var descriptionPickerView: UIPickerView!
    
    @IBOutlet weak var programButton: UIButton!
    @IBOutlet weak var semesterButton: UIButton!
    
    let navigationBarLeftButton = UIButton()
    let navigationBarRightButton = UIButton()
    
    var timeMutableArray = NSMutableArray()
    var courseTableViewArray = NSMutableArray()
    var pickerDataArray = NSMutableArray()
    var selectedPickerIndex = Int()
    var selectedSemester = String()
    var selectedProgram = String()

    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        setNavigationBarUI()
    }
    
    func setupUI()
    {
        self.programButton.layer.cornerRadius = 5
        self.programButton.clipsToBounds = true
        
        self.semesterButton.layer.cornerRadius = 5
        self.semesterButton.clipsToBounds = true
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.isNavigationBarHidden = false
        
        navigationBarLeftButton.setImage(UIImage(named: "left-arrow"), for: UIControlState())
        navigationBarLeftButton.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        navigationBarLeftButton.addTarget(self, action: #selector(backButtonPressed(_:)), for: .touchUpInside)
        let leftBarButton = UIBarButtonItem()
        leftBarButton.customView = navigationBarLeftButton
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let navigationBarLabel =  UILabel()
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 30)
//        navigationBarLabel.font = UIFont(name: "Helvetica Neue")
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.text = "Courses"
        self.navigationItem.titleView = navigationBarLabel
        
        navigationBarRightButton.setTitle("Show", for: .normal)
        navigationBarRightButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        navigationBarRightButton.addTarget(self, action: #selector(showButtonPressed(_:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = navigationBarRightButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func showButtonPressed(_ sender: UIBarButtonItem)
    {
        self.courseTableViewArray = NSMutableArray()
        self.courseTableViewArray = DataBaseUtility.sharedInstance.getCourseSemesterWiseArray(program: self.selectedProgram, semester: self.selectedSemester)
        if self.courseTableViewArray.count > 0
        {
//            print(self.courseTableViewArray)
            self.buttonContainerStackView.isHidden = true
            self.courseTableView.isHidden = false
            self.courseTableView.reloadData()
        }
        else
        {
            let alert = UIAlertController(title: "No courses found!", message: nil, preferredStyle: .alert) // 1
            let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                _ = self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(firstAction)
            self.present(alert, animated: true, completion:nil)
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func doneButtonPressed()
    {
        self.alphaView.isHidden = true
        self.timeTableContainerView.isHidden = true
    }
    
    @IBAction func programButtonPressed()
    {
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add("BSCS")
        array.add("BSSE")
        array.add("MCS")
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Program", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func semesterDoneButtonPressed()
    {
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add("1st")
        array.add("2nd")
        array.add("3rd")
        array.add("4th")
        array.add("5th")
        array.add("6th")
        array.add("7th")
        array.add("8th")
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Semester", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func pickerDoneButtonPressed()
    {
        self.pickerContainerView.isHidden = true
        let nameDict = self.pickerDataArray.object(at: selectedPickerIndex) as! NSMutableDictionary
        let index = nameDict.value(forKey: "Index") as! String
        if index == "Program"
        {
            selectedProgram = nameDict.value(forKey: "Data") as! String
            self.programButton.setTitle(selectedProgram, for: .normal)
        }
        else if index == "Semester"
        {
            selectedSemester = nameDict.value(forKey: "Data") as! String
            self.semesterButton.setTitle(selectedSemester, for: .normal)
        }
    }
    
    // MARK: - Api Calling
    
    func callApiToGetTimeCourseWise(id: String)
    {
        EZLoadingActivity.show("Loading...", disableUI: false)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "course_id": id,
            ]
        performRequestToGetTeachers(parameters: parameters)
    }
    
    func performRequestToGetTeachers(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.GetTimeCourseWise, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                                print(cardJsonObject as Any)
                
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
                                
                                self.timeMutableArray.add(timeModel)
                            }
                            
                            if self.timeMutableArray.count > 0
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
        if tableView == self.courseTableView
        {
            return self.courseTableViewArray.count
        }
        else
        {
            if appDelegate.isComingFromStudentCourseViewController
            {
                return self.timeMutableArray.count
            }
            else
            {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.tableFooterView = UIView()
        if tableView == self.courseTableView
        {
            let courseCell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseTableViewCell
            
            let courseModel = self.courseTableViewArray.object(at: indexPath.row) as! Course
            
            courseCell.courseCreditHourLabel.text = courseModel.credit_hours
            courseCell.courseNameLabel.text = courseModel.name
            courseCell.courseNumberLabel.text = courseModel.number
            
            return courseCell
        }
        else
        {
            if appDelegate.isComingFromStudentCourseViewController
            {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeTableViewCell
                
                let timeModel = self.timeMutableArray.object(at: indexPath.row) as! Time
                let teacherModel = timeModel.teacherData
                let courseModel = timeModel.courseData
                
                timeCell.teacherValueLabel.text = teacherModel.name
                timeCell.courseValueLabel.text = courseModel.name
                timeCell.timeValueLabel.text = timeModel.time_duration
                timeCell.locationValueLabel.text = "FF 07"
                
                return timeCell
            }
            else
            {
                let timeCell = tableView.dequeueReusableCell(withIdentifier: "timeCell", for: indexPath) as! TimeTableViewCell
                
                return timeCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        editingIndexPath = indexPath as NSIndexPath
        tableView.deselectRow(at: indexPath, animated: true)
        
        if appDelegate.isComingFromStudentCourseViewController
        {
            if tableView == self.courseTableView
            {
                let courseModel = self.courseTableViewArray.object(at: indexPath.row) as! Course
                callApiToGetTimeCourseWise(id: courseModel.server_id)
            }
        }
    }
    
    // MARK: - Picker View Delegate And Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.pickerDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        selectedPickerIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let nameDict = self.pickerDataArray.object(at: row) as! NSMutableDictionary
        let name = nameDict.value(forKey: "Data") as? String
        return name
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
