//
//  ShowCoursesViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class ShowCoursesViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource ,UIPickerViewDelegate , UIPickerViewDataSource{
    
    @IBOutlet weak var pickerContainerView: UIView!
    
    @IBOutlet weak var buttonContainerStackView: UIStackView!
    
    @IBOutlet weak var courseTableView: UITableView!
    
    @IBOutlet weak var descriptionPickerView: UIPickerView!
    
    @IBOutlet weak var programButton: UIButton!
    @IBOutlet weak var semesterButton: UIButton!
    
    let navigationBarLeftButton = UIButton()
    let navigationBarRightButton = UIButton()
    
    var courseTableViewArray = NSMutableArray()
    var pickerDataArray = NSMutableArray()
    var selectedPickerIndex = Int()
    var selectedSemester = String()
    var selectedProgram = String()

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
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
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
        self.courseTableViewArray = DataBaseUtility.sharedInstance.getCourseSemesterWise(program: self.selectedProgram, semester: self.selectedSemester)
        if self.courseTableViewArray.count > 0
        {
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
    
    // MARK: - Table View Delegate And Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.courseTableViewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let courseCell = tableView.dequeueReusableCell(withIdentifier: "courseCell", for: indexPath) as! CourseTableViewCell
        
        let courseModel = self.courseTableViewArray.object(at: indexPath.row) as! Course
        
        courseCell.courseCreditHourLabel.text = courseModel.credit_hours
        courseCell.courseNameLabel.text = courseModel.name
        courseCell.courseNumberLabel.text = courseModel.number
        
        return courseCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        editingIndexPath = indexPath as NSIndexPath
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
