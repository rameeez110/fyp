//
//  NewCreateTimeViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 4/28/18.
//  Copyright © 2018 AnyCart. All rights reserved.
//

import UIKit

class NewCreateTimeViewController: UIViewController{
    
    @IBOutlet weak var pickerContainerView: UIView!
    
    @IBOutlet weak var timeTableMetaPickerView: UIPickerView!
    
    @IBOutlet weak var teacherButton: UIButton!
    @IBOutlet weak var courseButton: UIButton!
    @IBOutlet weak var firstChoiceButton: UIButton!
    @IBOutlet weak var secondChoiceButton: UIButton!
    @IBOutlet weak var thirdChoiceButton: UIButton!
    @IBOutlet weak var fourthChoiceButton: UIButton!
    @IBOutlet weak var programButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var semesterButton: UIButton!
    @IBOutlet weak var moringButton: UIButton!
    @IBOutlet weak var generateButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    var pickerDataArray = NSMutableArray()
    var selectedPickerIndex = Int()
    let navigationBarLeftButton = UIButton()
    var timeTableModel = TimeTable()
    var selectedCourseIndex = Int()
    var selectedTeacherIndex = Int()
//    var teacherArray = NSMutableArray()
//    var courseArray = NSMutableArray()
    var teacherArray = [TeacherLocalModel]()
    var courseArray = [Course]()
    var isFirstTime = true

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigationBarUI()
        teacherArray = DataBaseUtility.sharedInstance.getAllTeacher()
        self.generateButton.isHidden = true
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
        navigationBarLabel.text = "Create Time Table"
        self.navigationItem.titleView = navigationBarLabel
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func choices(choice: Choice){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add(Days.Monday.rawValue)
        array.add(Days.Tuesday.rawValue)
        array.add(Days.Wednesday.rawValue)
        array.add(Days.Thursday.rawValue)
        array.add(Days.Friday.rawValue)
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Day", forKey: "Index")
            dict.setValue(choice.rawValue, forKey: "Choice")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.timeTableMetaPickerView.reloadAllComponents()
    }
    
    // MARK: - IBActions
    
    @IBAction func teacherButtonPressed(){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
        self.pickerDataArray = NSMutableArray()
        for model in teacherArray
        {
            if !model.isSelected{
                let dict = NSMutableDictionary()
                dict.setValue("Teacher Name", forKey: "Index")
                dict.setValue(model.name, forKey: "Data")
                dict.setValue(model.serverID, forKey: "ID")
                self.pickerDataArray.add(dict)
            }
        }
        self.timeTableMetaPickerView.reloadAllComponents()
    }
    
    @IBAction func courseButtonPressed(){
        let program = self.programButton.title(for: .normal)
        let semester = self.semesterButton.title(for: .normal)
        if program == "Select Program"
        {
            self.pickerContainerView.isHidden = true
            let alert = UIAlertController(title: "Please select program first!", message: nil, preferredStyle: .alert) // 1
            let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
            }
            alert.addAction(firstAction)
            self.present(alert, animated: true, completion:nil)
        }
        else if semester == "Select Semester"
        {
            self.pickerContainerView.isHidden = true
            let alert = UIAlertController(title: "Please select semester first!", message: nil, preferredStyle: .alert) // 1
            let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
            }
            alert.addAction(firstAction)
            self.present(alert, animated: true, completion:nil)
        }
        else
        {
            self.pickerContainerView.isHidden = false
            selectedPickerIndex = 0
            self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
            self.pickerDataArray = NSMutableArray()
            if self.isFirstTime{
                courseArray = DataBaseUtility.sharedInstance.getCourseSemesterWise(program: program!, semester: semester!)
                self.isFirstTime = false
            }
            for model in courseArray
            {
                if !model.isSelected{
                    let dict = NSMutableDictionary()
                    dict.setValue("Course Name", forKey: "Index")
                    dict.setValue(model.name, forKey: "Data")
                    dict.setValue(model.server_id, forKey: "ID")
                    dict.setValue(model.semester, forKey: "Semester")
                    self.pickerDataArray.add(dict)
                }
            }
            self.timeTableMetaPickerView.reloadAllComponents()
        }
    }
    
    @IBAction func firstChoiceButtonPressed(){
        choices(choice: Choice(rawValue: Choice.First.rawValue)!)
    }
    @IBAction func secondChoiceButtonPressed(){
        choices(choice: Choice(rawValue: Choice.Second.rawValue)!)
    }
    @IBAction func thirdChoiceButtonPressed(){
        choices(choice: Choice(rawValue: Choice.Third.rawValue)!)
    }
    @IBAction func fourthChoiceButtonPressed(){
        choices(choice: Choice(rawValue: Choice.Fourth.rawValue)!)
    }
    @IBAction func programButtonPressed(){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
        
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add(Program.BSCS.rawValue)
        array.add(Program.BSSE.rawValue)
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Program", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.timeTableMetaPickerView.reloadAllComponents()
    }
    @IBAction func yearButtonPressed(){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add("2018")
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Year", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.timeTableMetaPickerView.reloadAllComponents()
    }
    @IBAction func semesterButtonPressed(){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add(Semester.First.rawValue)
        array.add(Semester.Second.rawValue)
        array.add(Semester.Third.rawValue)
        array.add(Semester.Fourth.rawValue)
        array.add(Semester.Fifth.rawValue)
        array.add(Semester.Sixth.rawValue)
        array.add(Semester.Seventh.rawValue)
        array.add(Semester.Eighth.rawValue)
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Semester", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.timeTableMetaPickerView.reloadAllComponents()
    }
    @IBAction func morningButtonPressed(){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add(Shift.Morning.rawValue)
        array.add(Shift.Evening.rawValue)
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Morning/Evening", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.timeTableMetaPickerView.reloadAllComponents()
    }
    @IBAction func nextButtonPressed(){
        print(self.timeTableModel as Any)
        
        if self.timeTableModel.isMorning != "" && self.timeTableModel.semester != "" && self.timeTableModel.program != "" && self.timeTableModel.year != ""{
            self.programButton.isHidden = true
            self.yearButton.isHidden = true
            self.moringButton.isHidden = true
            self.semesterButton.isHidden = true
            if self.selectedTeacherIndex < self.timeTableModel.teacherModel.count{
                let model = self.timeTableModel.teacherModel[self.selectedTeacherIndex]
                if let index = self.teacherArray.index(where: {$0.serverID == model.serverID}){
                    self.teacherArray[index].isSelected = true
                }
                self.selectedTeacherIndex = self.selectedTeacherIndex + 1
                self.teacherButton.setTitle("Select Teacher", for: .normal)
                self.firstChoiceButton.setTitle("1st Choice", for: .normal)
                self.secondChoiceButton.setTitle("2nd Choice", for: .normal)
                self.thirdChoiceButton.setTitle("3rd Choice", for: .normal)
                self.fourthChoiceButton.setTitle("4th Choice", for: .normal)
            }
            if self.selectedCourseIndex < self.timeTableModel.courseModel.count{
                let model = self.timeTableModel.courseModel[self.selectedCourseIndex]
                if let index = self.courseArray.index(where: {$0.server_id == model.server_id}){
                    self.courseArray[index].isSelected = true
                }
                self.selectedCourseIndex = self.selectedCourseIndex + 1
                self.courseButton.setTitle("Select Course", for: .normal)
            }
        }
        else{
            let alert = UIAlertController(title: "Please fill all fields!", message: nil, preferredStyle: .alert) // 1
            let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
            }
            alert.addAction(firstAction)
            self.present(alert, animated: true, completion:nil)
        }
        
        let array = self.teacherArray.filter({$0.isSelected == true})
        if array.count == self.teacherArray.count
        {
            self.nextButton.isHidden = true
            self.generateButton.isHidden = false
        }
        
    }
    @IBAction func generateButtonPressed(){
        
        print(self.timeTableModel as Any)
    }
    @IBAction func doneButtonPressed()
    {
        self.pickerContainerView.isHidden = true
        let nameDict = self.pickerDataArray.object(at: selectedPickerIndex) as! NSMutableDictionary
        let index = nameDict.value(forKey: "Index") as! String
        if index == "Program"
        {
            self.programButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            self.timeTableModel.program = nameDict.value(forKey: "Data") as! String
        }
        else if index == "Semester"
        {
            self.semesterButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            self.timeTableModel.semester = nameDict.value(forKey: "Data") as! String
        }
        else if index == "Year"
        {
            self.yearButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            self.timeTableModel.year = nameDict.value(forKey: "Data") as! String
        }
        else if index == "Teacher Name"
        {
            self.teacherButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            let teacherServerId = nameDict.value(forKey: "ID") as! String
            if let teacherModel = DataBaseUtility.sharedInstance.getTeacher(serverID: teacherServerId).first{
                self.timeTableModel.teacherModel.append(teacherModel)
            }
        }
        else if index == "Course Name"
        {
            self.courseButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            let courseServerId = nameDict.value(forKey: "ID") as! String
            if let courseModel = DataBaseUtility.sharedInstance.getCourse(serverID: courseServerId).first{
                self.timeTableModel.courseModel.append(courseModel)
            }
        }
        else if index == "Morning/Evening"
        {
            self.moringButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            self.timeTableModel.isMorning = nameDict.value(forKey: "Data") as! String
        }
        else if index == "Day"
        {
            let choice = nameDict.value(forKey: "Choice") as! Choice.RawValue
            if choice == Choice.First.rawValue{
                self.firstChoiceButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
                self.timeTableModel.teacherModel[self.selectedTeacherIndex].firstChoice = nameDict.value(forKey: "Data") as! String
            }
            else if choice == Choice.Second.rawValue{
                self.secondChoiceButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
                self.timeTableModel.teacherModel[self.selectedTeacherIndex].firstChoice = nameDict.value(forKey: "Data") as! String
            }
            else if choice == Choice.Third.rawValue{
                self.thirdChoiceButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
                self.timeTableModel.teacherModel[self.selectedTeacherIndex].firstChoice = nameDict.value(forKey: "Data") as! String
            }
            else{
                self.fourthChoiceButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
                self.timeTableModel.teacherModel[self.selectedTeacherIndex].firstChoice = nameDict.value(forKey: "Data") as! String
            }
        }
    }
}

extension NewCreateTimeViewController: UIPickerViewDelegate , UIPickerViewDataSource{
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
}
