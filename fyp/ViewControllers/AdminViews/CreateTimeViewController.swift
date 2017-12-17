//
//  CreateTimeViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import Alamofire
import EZLoadingActivity

class CreateTimeViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource ,UIPickerViewDelegate , UIPickerViewDataSource{
    
    @IBOutlet weak var pickerContainerView: UIView!
    
    @IBOutlet weak var timeTableView: UITableView!
    
    @IBOutlet weak var timeTableMetaPickerView: UIPickerView!
    
    let navigationBarLeftButton = UIButton()
    let navigationBarRightButton = UIButton()
    
    var selectedCourseID = String()
    var selectedTeacherID = String()
    var semester = String()
    
    var teacherMutableArray = NSMutableArray()
    var timeTitleLabelArray = NSMutableArray()
    var timeTitleButtonArray = NSMutableArray()
    var pickerDataArray = NSMutableArray()
    var selectedPickerIndex = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadLabelsArray()
        setNavigationBarUI()
        callApiToGetTeachers()
    }
    
    func loadLabelsArray()
    {
        timeTitleLabelArray = NSMutableArray()
        timeTitleButtonArray = NSMutableArray()
        
        self.timeTitleLabelArray.add("Program")
        self.timeTitleLabelArray.add("Teacher Name")
        self.timeTitleLabelArray.add("Course Name")
        self.timeTitleLabelArray.add("Morning/Evening")
        self.timeTitleLabelArray.add("Day")
        self.timeTitleLabelArray.add("Time")
        self.timeTitleLabelArray.add("Theory/Lab")
        self.timeTitleLabelArray.add("Section")
        
        self.timeTitleButtonArray.add("Select Here")
        self.timeTitleButtonArray.add("Select Here")
        self.timeTitleButtonArray.add("Select Here")
        self.timeTitleButtonArray.add("Select Here")
        self.timeTitleButtonArray.add("Select Here")
        self.timeTitleButtonArray.add("Select Here")
        self.timeTitleButtonArray.add("Select Here")
        self.timeTitleButtonArray.add("Select Here")
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        
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
        navigationBarLabel.text = "Create Time"
        self.navigationItem.titleView = navigationBarLabel
        
        navigationBarRightButton.setTitle("Save", for: .normal)
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
        var status = false
        for i in 0..<self.timeTitleButtonArray.count
        {
            let data = self.timeTitleButtonArray.object(at: i) as! String
            if data == "Select Here"
            {
                status = true
                break
            }
        }
        if status
        {
            let alert = UIAlertController(title: "All fields are required!", message: "Please fill all fields to schedule class time.", preferredStyle: .alert) // 1
            let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
            }
            alert.addAction(firstAction)
            self.present(alert, animated: true, completion:nil)
        }
        else
        {
            EZLoadingActivity.show("Loading...", disableUI: false)
            callApiToAddTime()
        }
    }
    
    @IBAction func doneButtonPressed()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.pickerContainerView.isHidden = true
        let nameDict = self.pickerDataArray.object(at: selectedPickerIndex) as! NSMutableDictionary
        let index = nameDict.value(forKey: "Index") as! String
        if index == "Program"
        {
            self.timeTitleButtonArray.replaceObject(at: 0, with: nameDict.value(forKey: "Data") as! String)
            self.timeTableView.reloadRows(at: [IndexPath (row: 0, section: 0)], with: .none)
        }
        else if index == "Teacher Name"
        {
            selectedTeacherID = nameDict.value(forKey: "ID") as! String
            self.timeTitleButtonArray.replaceObject(at: 1, with: nameDict.value(forKey: "Data") as! String)
            self.timeTableView.reloadRows(at: [IndexPath (row: 1, section: 0)], with: .none)
        }
        else if index == "Course Name"
        {
            semester = nameDict.value(forKey: "Semester") as! String
            selectedCourseID = nameDict.value(forKey: "ID") as! String
            self.timeTitleButtonArray.replaceObject(at: 2, with: nameDict.value(forKey: "Data") as! String)
            self.timeTableView.reloadRows(at: [IndexPath (row: 2, section: 0)], with: .none)
        }
        else if index == "Morning/Evening"
        {
            self.timeTitleButtonArray.replaceObject(at: 3, with: nameDict.value(forKey: "Data") as! String)
            self.timeTableView.reloadRows(at: [IndexPath (row: 3, section: 0)], with: .none)
        }
        else if index == "Day"
        {
            self.timeTitleButtonArray.replaceObject(at: 4, with: nameDict.value(forKey: "Data") as! String)
            self.timeTableView.reloadRows(at: [IndexPath (row: 4, section: 0)], with: .none)
        }
        else if index == "Time"
        {
            self.timeTitleButtonArray.replaceObject(at: 5, with: nameDict.value(forKey: "Data") as! String)
            self.timeTableView.reloadRows(at: [IndexPath (row: 5, section: 0)], with: .none)
        }
        else if index == "Theory/Lab"
        {
            self.timeTitleButtonArray.replaceObject(at: 6, with: nameDict.value(forKey: "Data") as! String)
            self.timeTableView.reloadRows(at: [IndexPath (row: 6, section: 0)], with: .none)
        }
        else if index == "Section"
        {
            self.timeTitleButtonArray.replaceObject(at: 7, with: nameDict.value(forKey: "Data") as! String)
            self.timeTableView.reloadRows(at: [IndexPath (row: 7, section: 0)], with: .none)
        }
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
                                self.teacherMutableArray.add(teacher)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func callApiToAddTime()
    {
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "teacher_id": selectedTeacherID,
            "course_id": selectedCourseID,
            "day": self.timeTitleButtonArray.object(at: 4) as! String,
            "program": self.timeTitleButtonArray.object(at: 0) as! String,
            "year": "2017",
            "is_morning": self.timeTitleButtonArray.object(at: 3) as! String,
            "time_duration": self.timeTitleButtonArray.object(at: 5) as! String,
            "is_theory": self.timeTitleButtonArray.object(at: 6) as! String,
            "section": self.timeTitleButtonArray.object(at: 7) as! String,
            "meta": "last semester",
            "semester": semester,
            ]
        performRequestToAddTime(parameters: parameters)
    }
    
    func performRequestToAddTime(parameters: Parameters)
    {
//        Alamofire.request("https://rameeez110.000webhostapp.com/fyp/web/index.php/webservice/addtime/", parameters: parameters).responseData { response in
        Alamofire.request(URLConstants.APPURL.AddTime, parameters: parameters).responseData { response in
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                //                print(cardJsonObject as Any)
                EZLoadingActivity.hide(true, animated: true)
                if (cardJsonObject?.value(forKey: "response")) != nil
                {
                    //                        print(dataDict as Any)
                    let result = cardJsonObject?.value(forKey: "response") as! String
                    
                    if result == "SUCCESS"
                    {
                        let alert = UIAlertController(title: "Time added succesfuly!", message: nil, preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                            self.loadLabelsArray()
                            self.timeTableView.reloadData()
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
        return self.timeTitleLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let insertTimeCell = tableView.dequeueReusableCell(withIdentifier: "createTimeTable", for: indexPath) as! CreateTimeTableViewCell

        insertTimeCell.titleLabel.text = self.timeTitleLabelArray.object(at: indexPath.row) as? String
        insertTimeCell.descriptionButton.setTitle(self.timeTitleButtonArray.object(at: indexPath.row) as? String, for: .normal)
        
        insertTimeCell.descriptionButton.addTarget(self, action: #selector(addressStateButtonPressed(sender:)), for: .touchUpInside)
        insertTimeCell.descriptionButton.tag = indexPath.row

        return insertTimeCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        editingIndexPath = indexPath as NSIndexPath
    }
    
    @objc func addressStateButtonPressed(sender: UIButton) {
        let buttonTag = sender.tag
        self.navigationController?.isNavigationBarHidden = true
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
        if buttonTag == 0
        {
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
            self.timeTableMetaPickerView.reloadAllComponents()
        }
        else if buttonTag == 1
        {
            self.pickerDataArray = NSMutableArray()
            for data in self.teacherMutableArray
            {
                let model = data as! NSDictionary
                let dict = NSMutableDictionary()
                dict.setValue("Teacher Name", forKey: "Index")
                dict.setValue(model.value(forKey: "name") as! String, forKey: "Data")
                dict.setValue(model.value(forKey: "id") as! String, forKey: "ID")
                self.pickerDataArray.add(dict)
            }
            self.timeTableMetaPickerView.reloadAllComponents()
        }
        else if buttonTag == 2
        {
            let program = self.timeTitleButtonArray.object(at: 0) as! String
            if program == "Select Here"
            {
                self.pickerContainerView.isHidden = true
                let alert = UIAlertController(title: "Please select program first!", message: nil, preferredStyle: .alert) // 1
                let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                }
                alert.addAction(firstAction)
                self.present(alert, animated: true, completion:nil)
            }
            else
            {
                self.pickerDataArray = NSMutableArray()
                let array = DataBaseUtility.sharedInstance.getCourseProgramWise(program: program)
                for data in array
                {
                    let model = data as! Course
                    let dict = NSMutableDictionary()
                    dict.setValue("Course Name", forKey: "Index")
                    dict.setValue(model.name, forKey: "Data")
                    dict.setValue(model.server_id, forKey: "ID")
                    dict.setValue(model.semester, forKey: "Semester")
                    self.pickerDataArray.add(dict)
                }
                self.timeTableMetaPickerView.reloadAllComponents()
            }
        }
        else if buttonTag == 3
        {
            let array = NSMutableArray()
            self.pickerDataArray = NSMutableArray()
            array.add("Morning")
            array.add("Evening")
            for data in array
            {
                let dict = NSMutableDictionary()
                dict.setValue("Morning/Evening", forKey: "Index")
                dict.setValue(data as! String, forKey: "Data")
                self.pickerDataArray.add(dict)
            }
            self.timeTableMetaPickerView.reloadAllComponents()
        }
        else if buttonTag == 4
        {
            let array = NSMutableArray()
            self.pickerDataArray = NSMutableArray()
            array.add("Monday")
            array.add("Tuesday")
            array.add("Wednesday")
            array.add("Thursday")
            array.add("Friday")
            for data in array
            {
                let dict = NSMutableDictionary()
                dict.setValue("Day", forKey: "Index")
                dict.setValue(data as! String, forKey: "Data")
                self.pickerDataArray.add(dict)
            }
            self.timeTableMetaPickerView.reloadAllComponents()
        }
        else if buttonTag == 5
        {
            let info = self.timeTitleButtonArray.object(at: 3) as! String
            if info == "Select Here"
            {
                self.pickerContainerView.isHidden = true
                let alert = UIAlertController(title: "Please Select Morning or Evening!", message: nil, preferredStyle: .alert) // 1
                let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                }
                alert.addAction(firstAction)
                self.present(alert, animated: true, completion:nil)
            }
            else if info == "Morning"
            {
                let day = self.timeTitleButtonArray.object(at: 4) as! String
                let array = NSMutableArray()
                self.pickerDataArray = NSMutableArray()
                if day == "Friday"
                {
                    array.add("9:00 - 10:40")
                    array.add("10:40 - 12:20")
                }
                else
                {
                    array.add("9:00 - 10:50")
                    array.add("11:00 - 12:50")
                    array.add("1:50 - 3:30")
                }
                for data in array
                {
                    let dict = NSMutableDictionary()
                    dict.setValue("Time", forKey: "Index")
                    dict.setValue(data as! String, forKey: "Data")
                    self.pickerDataArray.add(dict)
                }
                self.timeTableMetaPickerView.reloadAllComponents()
            }
            else if info == "Evening"
            {
                let array = NSMutableArray()
                self.pickerDataArray = NSMutableArray()
                array.add("3:30 - 5:10")
                array.add("5:10 - 6:50")
                array.add("6:50 - 8:30")
                for data in array
                {
                    let dict = NSMutableDictionary()
                    dict.setValue("Time", forKey: "Index")
                    dict.setValue(data as! String, forKey: "Data")
                    self.pickerDataArray.add(dict)
                }
                self.timeTableMetaPickerView.reloadAllComponents()
            }
        }
        else if buttonTag == 6
        {
            let array = NSMutableArray()
            self.pickerDataArray = NSMutableArray()
            array.add("Thoery")
            array.add("Lab")
            for data in array
            {
                let dict = NSMutableDictionary()
                dict.setValue("Theory/Lab", forKey: "Index")
                dict.setValue(data as! String, forKey: "Data")
                self.pickerDataArray.add(dict)
            }
            self.timeTableMetaPickerView.reloadAllComponents()
        }
        else if buttonTag == 7
        {
            let array = NSMutableArray()
            self.pickerDataArray = NSMutableArray()
            array.add("Section A")
            array.add("Section B")
            for data in array
            {
                let dict = NSMutableDictionary()
                dict.setValue("Section", forKey: "Index")
                dict.setValue(data as! String, forKey: "Data")
                self.pickerDataArray.add(dict)
            }
            self.timeTableMetaPickerView.reloadAllComponents()
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
