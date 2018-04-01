//
//  FullTimeTableMorningViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 12/10/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import G3GridView
import Foundation

class FullTimeTableMorningViewController: UIViewController {

    @IBOutlet weak var timeTableView: GridView!
    @IBOutlet weak var timeListView: GridView!
    @IBOutlet weak var dayView: GridView!
    
    @IBOutlet weak var transparentView: UIView!
    @IBOutlet weak var timeTableInfoContainerViewView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var courseNoLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseInstructorLabel: UILabel!
    @IBOutlet weak var courseCreditHoursLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    
    public var timeTableMutableArray = NSMutableArray()
    var timeTable2DMutableDict = NSMutableDictionary()
    var lunchTimeLabelArray = NSMutableArray()
    
    let timeArray = NSMutableArray()
    var timeListDataSource: TimeListDataSourceMorning?
    private let dayDataSource = DayGridViewDataSourceMorning()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBarUI()
        fillTimeArray()
        fillTimeTable2DArray()
        
        self.navigationController?.navigationBar.isHidden = true
        
        timeListDataSource = .init(channels: self.timeArray)
        
        timeTableView.register(DataGridViewCell.nib, forCellWithReuseIdentifier: "DataGridViewCell")
        timeListView.register(TimeGridViewCell.nib, forCellWithReuseIdentifier: "TimeGridViewCell")
        dayView.register(DayGridViewCell.nib, forCellWithReuseIdentifier: "DayGridViewCell")
        
        //        timeTableView.layoutWithoutFillForCell = true
        timeTableView.superview?.clipsToBounds = true
        timeTableView.contentInset.top = timeListView.bounds.height
        timeTableView.minimumScale = Scale(x: 0.5, y: 0.5)
        timeTableView.maximumScale = Scale(x: 1.5, y: 1.5)
        timeTableView.scrollIndicatorInsets.top = timeTableView.contentInset.top
        timeTableView.scrollIndicatorInsets.left = dayView.bounds.width
        timeTableView.dataSource = self
        timeTableView.delegate = self
        timeTableView.isInfinitable = false
        timeTableView.reloadData()
        
        //        channelListView.layoutWithoutFillForCell = true
        timeListView.superview?.backgroundColor = .white
        timeListView.superview?.isUserInteractionEnabled = false
        timeListView.minimumScale.x = timeTableView.minimumScale.x
        timeListView.maximumScale.x = timeTableView.maximumScale.x
        timeListView.dataSource = timeListDataSource
        timeListView.delegate = timeListDataSource
        timeListView.isInfinitable = false
        timeListView.reloadData()
        
        dayView.superview?.clipsToBounds = true
        dayView.superview?.backgroundColor = .white
        dayView.superview?.isUserInteractionEnabled = false
        dayView.contentInset.top = timeListView.bounds.height
        dayView.minimumScale.y = timeTableView.minimumScale.y
        dayView.maximumScale.y = timeTableView.maximumScale.y
        dayView.isInfinitable = false
        dayView.dataSource = dayDataSource
        dayView.delegate = dayDataSource
        dayView.reloadData()
        
        self.courseNoLabel.layer.cornerRadius = 5
        self.courseNoLabel.clipsToBounds = true
        self.courseNameLabel.layer.cornerRadius = 5
        self.courseNameLabel.clipsToBounds = true
        self.courseInstructorLabel.layer.cornerRadius = 5
        self.courseInstructorLabel.clipsToBounds = true
        self.courseCreditHoursLabel.layer.cornerRadius = 5
        self.courseCreditHoursLabel.clipsToBounds = true
        self.courseLocationLabel.layer.cornerRadius = 5
        self.courseLocationLabel.clipsToBounds = true
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationController?.isNavigationBarHidden = false
        
        let navigationBarLeftButton = UIButton()
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
        navigationBarLabel.text = "Full Time Table"
        self.navigationItem.titleView = navigationBarLabel
    }
    
    @objc func backButtonPressed(_ sender: UIBarButtonItem)
    {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func fillTimeArray()
    {
        self.timeArray.add("9:00 - 10:50")
        self.timeArray.add("11:00 - 12:50")
        self.timeArray.add("12:50 - 1:50")
        self.timeArray.add("1:50 - 3:30")
        self.timeArray.add("9:00 - 10:40")
        self.timeArray.add("10:40 - 12:20")
        
        self.lunchTimeLabelArray.add("k  ")
        self.lunchTimeLabelArray.add("rea")
        self.lunchTimeLabelArray.add("r B")
        self.lunchTimeLabelArray.add("aye")
        self.lunchTimeLabelArray.add(" Pr")
        self.lunchTimeLabelArray.add("And")
        self.lunchTimeLabelArray.add("ch ")
        self.lunchTimeLabelArray.add("Lun")
    }
    
    func fillTimeTable2DArray()
    {
        for object in self.timeTableMutableArray
        {
            let dict = object as! NSDictionary
            let day = dict.value(forKey: "day") as! String
            if day == "Monday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Morning"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "9:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "10")
                        }
                        else if time == "11:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "11")
                        }
                        else if time == "1:50 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "12")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "9:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "00")
                        }
                        else if time == "11:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "01")
                        }
                        else if time == "1:50 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "02")
                        }
                    }
                }
            }
            else if day == "Tuesday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Morning"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "9:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "30")
                        }
                        else if time == "11:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "31")
                        }
                        else if time == "1:50 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "32")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "9:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "20")
                        }
                        else if time == "11:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "21")
                        }
                        else if time == "1:50 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "22")
                        }
                    }
                }
            }
            else if day == "Wednesday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Morning"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "9:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "50")
                        }
                        else if time == "11:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "51")
                        }
                        else if time == "1:50 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "52")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "9:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "40")
                        }
                        else if time == "11:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "41")
                        }
                        else if time == "1:50 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "42")
                        }
                    }
                }
            }
            else if day == "Thursday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Morning"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "9:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "70")
                        }
                        else if time == "11:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "71")
                        }
                        else if time == "1:50 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "72")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "9:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "60")
                        }
                        else if time == "11:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "61")
                        }
                        else if time == "1:50 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "62")
                        }
                    }
                }
            }
            else if day == "Friday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Morning"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "9:00 - 10:40"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "90")
                        }
                        else if time == "10:40 - 12:20"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "91")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "9:00 - 10:40"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "80")
                        }
                        else if time == "10:40 - 12:20"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "81")
                        }
                    }
                }
            }
        }
        //        print(self.timeTable2DMutableDict as Any)
    }
    
    @IBAction func doneButtonPressed()
    {
        self.transparentView.isHidden = true
        self.timeTableInfoContainerViewView.isHidden = true
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

extension FullTimeTableMorningViewController: GridViewDataSource, GridViewDelegate {
    func numberOfColumns(in gridView: GridView) -> Int {
        return 4
    }
    
    func gridView(_ gridView: GridView, numberOfRowsInColumn column: Int) -> Int {
        return 10
    }
    
    func gridView(_ gridView: GridView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
    func gridView(_ gridView: GridView, cellForRowAt indexPath: IndexPath) -> GridViewCell {
        let cell = gridView.dequeueReusableCell(withReuseIdentifier: "DataGridViewCell", for: indexPath)
        if let cell = cell as? DataGridViewCell {
            
            if indexPath.column == 2
            {
                cell.borderView.backgroundColor = UIColor.white
                cell.borderView.layer.borderWidth = 0.5
                cell.borderView.layer.borderColor = UIColor.white.cgColor
                if indexPath.row != 0 && indexPath.row != 9
                {
                    cell.lunchLabel.isHidden = false
                    cell.lunchLabel.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / 2)
                    cell.lunchLabel.text = self.lunchTimeLabelArray.object(at: indexPath.row - 1) as? String
                }
                
                if indexPath.row == 0
                {
                    cell.lunchSeparatorTopView.isHidden = false
                    cell.lunchSeparatorBottomView.isHidden = true
                }
                else if indexPath.row == 9
                {
                    cell.lunchSeparatorTopView.isHidden = true
                    cell.lunchSeparatorBottomView.isHidden = false
                }
                else
                {
                    cell.lunchSeparatorTopView.isHidden = true
                    cell.lunchSeparatorBottomView.isHidden = true
                }
            }
            else
            {
                //hide separator view
                cell.lunchSeparatorTopView.isHidden = true
                cell.lunchSeparatorBottomView.isHidden = true
                
                cell.lunchLabel.isHidden = true
                let dict = getObjectAtIntersectionOfDayAndTime(indexPath: indexPath)
                if (dict["day"] as? String) != nil {
                    let courseArray = dict.value(forKey: "CourseData") as! NSArray
                    let courseDict = courseArray.object(at: 0) as! NSDictionary
                    let courseNo = courseDict.value(forKey: "number")
                    var theoryStatus = String()
                    let isTheory = dict.value(forKey: "is_theory") as! String
                    if isTheory == "Thoery"
                    {
                        theoryStatus = " (T)"
                    }
                    else
                    {
                        theoryStatus = " (L)"
                    }
                    let techerArray = dict.value(forKey: "TeacherData") as! NSArray
                    let techerDict = techerArray.object(at: 0) as! NSDictionary
                    let teacherName = techerDict.value(forKey: "name") as! String
                    let aray = teacherName.components(separatedBy: " ")
                    var teacherCode = String()
                    for i in 0..<aray.count
                    {
                        let gg = aray[i]
                        teacherCode = teacherCode + gg.components(separatedBy: " ")[0]
                    }
                    let course = courseNo as? String
                    let cellString = course! + theoryStatus + " (" + teacherCode + ")"
                    cell.configure(cellString)
                }
//                cell.configure("T 506 T")
                
                if indexPath.row % 2 == 0
                {
                    cell.borderView.backgroundColor = UIColor.white
                }
                else
                {
                    cell.borderView.backgroundColor = UIColor(red: 205/255, green: 215/255, blue: 219/255, alpha: 1)
                }
                cell.borderView.layer.borderWidth = 0.5
                cell.borderView.layer.borderColor = UIColor.black.cgColor
            }
        }
        
        return cell
    }
    
    func getObjectAtIntersectionOfDayAndTime(indexPath: IndexPath) -> NSDictionary
    {
        let key = String(indexPath.row) + String(indexPath.column)
        var dict = NSDictionary()
        
        if (self.timeTable2DMutableDict[key] as? NSDictionary) != nil
        {
            dict = self.timeTable2DMutableDict.value(forKey: key) as! NSDictionary
        }
        else
        {
            
        }
        
        return dict
    }
    
    func gridView(_ gridView: GridView, didScaleAt scale: CGFloat) {
        timeListView.contentScale(scale)
        dayView.contentScale(scale)
    }
    
    func gridView(_ gridView: GridView, didSelectRowAt indexPath: IndexPath) {
        gridView.deselectRow(at: indexPath)
        let dict = getObjectAtIntersectionOfDayAndTime(indexPath: indexPath)
        if (dict["day"] as? String) != nil {
            setupCourseInfo(model: dict)
        }
    }
    
    func setupCourseInfo(model: NSDictionary)
    {
        self.transparentView.isHidden = false
        self.timeTableInfoContainerViewView.isHidden = false
        let courseArray = model.value(forKey: "CourseData") as! NSArray
        let courseDict = courseArray.object(at: 0) as! NSDictionary
        let courseNo = courseDict.value(forKey: "number")
        self.courseNoLabel.text = courseNo as? String
        let techerArray = model.value(forKey: "TeacherData") as! NSArray
        let techerDict = techerArray.object(at: 0) as! NSDictionary
        let teacherName = techerDict.value(forKey: "name") as! String
        self.courseInstructorLabel.text = teacherName
        self.courseCreditHoursLabel.text = (courseDict.value(forKey: "credit_hours") as! String)
        self.courseNameLabel.text = courseDict.value(forKey: "name") as? String
        let isTheory = model.value(forKey: "is_theory") as! String
        if isTheory == "Thoery"
        {
            self.courseLocationLabel.text = "GF 22"
        }
        else
        {
            self.courseLocationLabel.text = "FF 01"
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        timeListView.contentOffset.x = scrollView.contentOffset.x
        dayView.contentOffset.y = scrollView.contentOffset.y
    }
}

final class DayGridViewDataSourceMorning: NSObject, GridViewDataSource, GridViewDelegate {
    
    func gridView(_ gridView: GridView, numberOfRowsInColumn column: Int) -> Int {
        return 5
    }
    
    func gridView(_ gridView: GridView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func gridView(_ gridView: GridView, cellForRowAt indexPath: IndexPath) -> GridViewCell {
        let cell = gridView.dequeueReusableCell(withReuseIdentifier: "DayGridViewCell", for: indexPath)
        if let cell = cell as? DayGridViewCell {
            cell.configure(indexPath.row)
        }
        
        return cell
    }
}

final class TimeListDataSourceMorning: NSObject, GridViewDataSource, GridViewDelegate {
    //    let channels: [String]
    var channels = NSMutableArray()
    
    init(channels: NSMutableArray) {
        self.channels = channels
    }
    
    func numberOfColumns(in gridView: GridView) -> Int {
        return 4//channels.count
    }
    
    func gridView(_ gridView: GridView, numberOfRowsInColumn column: Int) -> Int {
        return 2
    }
    
    func gridView(_ gridView: GridView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(40)
    }
    
    func gridView(_ gridView: GridView, cellForRowAt indexPath: IndexPath) -> GridViewCell {
        let cell = gridView.dequeueReusableCell(withReuseIdentifier: "TimeGridViewCell", for: indexPath)
        if let cell = cell as? TimeGridViewCell {
            if indexPath.row == 0
            {
                cell.configure(self.channels.object(at: indexPath.column) as! String)
            }
            else
            {
                if indexPath.column == 0
                {
                    cell.configure(self.channels.object(at: 4) as! String)
                }
                else if indexPath.column == 1
                {
                    cell.configure(self.channels.object(at: 5) as! String)
                }
                else
                {
                    cell.configure("")
                }
            }
        }
        
        return cell
    }
}
