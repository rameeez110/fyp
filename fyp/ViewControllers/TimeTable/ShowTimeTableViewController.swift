//
//  ShowTimeTableViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/29/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import Alamofire
import EZLoadingActivity

class ShowTimeTableViewController: UIViewController ,UIPickerViewDelegate , UIPickerViewDataSource{
    
    @IBOutlet weak var pickerContainerView: UIView!
    
    @IBOutlet weak var descriptionPickerView: UIPickerView!
    
    @IBOutlet weak var programButton: UIButton!
    @IBOutlet weak var semesterButton: UIButton!
    @IBOutlet weak var morningButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    
    let navigationBarLeftButton = UIButton()
    let navigationBarRightButton = UIButton()
    
    var pickerDataArray = NSMutableArray()
    var selectedPickerIndex = Int()
    
    var selectedSemester = String()
    var selectedProgram = String()
    var selectedYear = String()
    var selectedMorning = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarUI()
        setupUI()
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
        //        navigationBarLabel.font = UIFont(name: "Helvetica Neue")
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.text = "Time Table"
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
        if selectedProgram == "" || selectedYear == "" || selectedMorning == "" || selectedSemester == ""
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
            callApiToGetTimeTable()
        }
    }
    
    func setupUI()
    {
        self.programButton.layer.cornerRadius = 5
        self.programButton.clipsToBounds = true
        
        self.semesterButton.layer.cornerRadius = 5
        self.semesterButton.clipsToBounds = true
        
        self.morningButton.layer.cornerRadius = 5
        self.morningButton.clipsToBounds = true
        
        self.yearButton.layer.cornerRadius = 5
        self.yearButton.clipsToBounds = true
    }
    
    // MARK: - IBActions
    
    @IBAction func programButtonPressed()
    {
        self.navigationController?.isNavigationBarHidden = true
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.descriptionPickerView.selectRow(0, inComponent: 0, animated: true)
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
        self.navigationController?.isNavigationBarHidden = true
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.descriptionPickerView.selectRow(0, inComponent: 0, animated: true)
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
    
    @IBAction func MorningEveningButtonPressed()
    {
        self.navigationController?.isNavigationBarHidden = true
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.descriptionPickerView.selectRow(0, inComponent: 0, animated: true)
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
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func yearDoneButtonPressed()
    {
        self.navigationController?.isNavigationBarHidden = true
        self.pickerContainerView.isHidden = false
        selectedPickerIndex = 0
        self.descriptionPickerView.selectRow(0, inComponent: 0, animated: true)
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add("2017")
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Year", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func pickerDoneButtonPressed()
    {
        self.navigationController?.isNavigationBarHidden = false
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
        else if index == "Morning/Evening"
        {
            selectedMorning = nameDict.value(forKey: "Data") as! String
            self.morningButton.setTitle(selectedMorning, for: .normal)
        }
        else if index == "Year"
        {
            selectedYear = nameDict.value(forKey: "Data") as! String
            self.yearButton.setTitle(selectedYear, for: .normal)
        }
    }
    
    // MARK: - Api Calling
    
    func callApiToGetTimeTable()
    {
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "program": selectedProgram,
            "is_morning": selectedMorning,
            "semester": selectedSemester,
            "year": selectedYear,
            ]
        performRequestToGetTimeTable(parameters: parameters)
    }
    
    func performRequestToGetTimeTable(parameters: Parameters)
    {
//        Alamofire.request("https://rameeez110.000webhostapp.com/fyp/web/index.php/webservice/gettimetable/", parameters: parameters).responseData { response in
        Alamofire.request(URLConstants.APPURL.GetFullTimeTable, parameters: parameters).responseData { response in
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                EZLoadingActivity.hide(true, animated: true)
//                                print(cardJsonObject as Any)
                if (cardJsonObject?.value(forKey: "data")) != nil
                {
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
//                        print(dataDict as Any)
                        let timeArray = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        let array = NSMutableArray()
                        
                        if result == "SUCCESS"
                        {
                            for object in timeArray
                            {
                                let time = object as! NSDictionary
                                array.add(time)
                            }
                        }
                        if self.selectedMorning == "Morning"
                        {
                            let fullTimeTableMorningViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showTimeTableMorning") as! FullTimeTableMorningViewController
                            fullTimeTableMorningViewController.timeTableMutableArray = NSMutableArray()
                            fullTimeTableMorningViewController.timeTableMutableArray = array
                            self.navigationController!.pushViewController(fullTimeTableMorningViewController, animated:true)
                        }
                        else
                        {
                            let fullTimeTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showTimeTable") as! FullTimeTableViewController
                            fullTimeTableViewController.timeTableMutableArray = NSMutableArray()
                            fullTimeTableViewController.timeTableMutableArray = array
                            self.navigationController!.pushViewController(fullTimeTableViewController, animated:true)
                        }
                    }
                }
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
