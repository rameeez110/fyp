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
    
    // MARK: - IBActions
    
    /*@objc func addressStateButtonPressed(sender: UIButton) {
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
     }*/
    
    func choices(){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
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
    
    @IBAction func teacherButtonPressed(){
        
    }
    
    @IBAction func courseButtonPressed(){
        
    }
    
    @IBAction func firstChoiceButtonPressed(){
        choices()
    }
    
    @IBAction func secondChoiceButtonPressed(){
        choices()
    }
    @IBAction func thirdChoiceButtonPressed(){
        choices()
    }
    @IBAction func fourthChoiceButtonPressed(){
        choices()
    }
    @IBAction func programButtonPressed(){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.timeTableMetaPickerView.selectRow(0, inComponent: 0, animated: true)
        
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add("BSCS")
        array.add("BSSE")
//        array.add("MCS")
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
        self.timeTableMetaPickerView.reloadAllComponents()
    }
    @IBAction func morningButtonPressed(){
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
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
    @IBAction func nextButtonPressed(){
        
    }
    @IBAction func generateButtonPressed(){
        
    }
    @IBAction func doneButtonPressed()
    {
//        self.navigationController?.isNavigationBarHidden = false
        /*self.pickerContainerView.isHidden = true
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
        }*/
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
