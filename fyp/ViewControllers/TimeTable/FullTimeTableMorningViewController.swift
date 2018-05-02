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
    
    public var timeTableArray = [TimeLocalModel]()
    var timeTable2DMutableDict = NSMutableDictionary()
    var lunchTimeLabelArray = NSMutableArray()
    
    let timeArray = NSMutableArray()
    var timeListDataSource: TimeListDataSourceMorning?
    private let dayDataSource = DayGridViewDataSourceMorning()
    public var titleString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        setNavigationBarUI()
        fillTimeArray()
        fillTimeTable2DArray()
        
//        self.navigationController?.navigationBar.isHidden = false
        
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
//        let timeSlotsArray = ["9:00 - 9:50", "10:00 - 10:50", "11:00 - 11:50", "12:00 - 12:50", "1:50 - 2:40", "2:40 - 3:30"]
        
        self.timeArray.add("9:00 - 9:50")
        self.timeArray.add("10:00 - 10:50")
        self.timeArray.add("11:00 - 11:50")
        self.timeArray.add("12:00 - 12:50")
        self.timeArray.add("12:50 - 1:50")
        self.timeArray.add("1:50 - 2:40")
        self.timeArray.add("2:40 - 3:30")
        self.timeArray.add("9:00 - 9:50")
        self.timeArray.add("9:50 - 10:40")
        self.timeArray.add("10:40 - 11:30")
        self.timeArray.add("11:30 - 12:20")
        
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
        for object in self.timeTableArray
        {
            let day = object.day
            if day == Days.Monday.rawValue
            {
                let moring = object.isMorning
                if moring == Shift.Morning.rawValue
                {
                    let section = object.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "10")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "11")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "12")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "13")
                        }
                        else if time == "1:50 - 2:40"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "15")
                        }
                        else if time == "2:40 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "16")
                        }
                    }
                    else
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "00")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "01")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "02")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "03")
                        }
                        else if time == "1:50 - 2:40"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "05")
                        }
                        else if time == "2:40 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "06")
                        }
                    }
                }
            }
            else if day == Days.Tuesday.rawValue
            {
                let moring = object.isMorning
                if moring == Shift.Morning.rawValue
                {
                    let section = object.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "30")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "31")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "32")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "33")
                        }
                        else if time == "1:50 - 2:40"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "35")
                        }
                        else if time == "2:40 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "36")
                        }
                    }
                    else
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "20")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "21")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "22")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "23")
                        }
                        else if time == "1:50 - 2:40"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "25")
                        }
                        else if time == "2:40 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "26")
                        }
                    }
                }
            }
            else if day == Days.Wednesday.rawValue
            {
                let moring = object.isMorning
                if moring == Shift.Morning.rawValue
                {
                    let section = object.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "50")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "51")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "52")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "53")
                        }
                        else if time == "1:50 - 2:40"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "55")
                        }
                        else if time == "2:40 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "56")
                        }
                    }
                    else
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "40")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "41")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "42")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "43")
                        }
                        else if time == "1:50 - 2:40"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "45")
                        }
                        else if time == "2:40 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "46")
                        }
                    }
                }
            }
            else if day == Days.Thursday.rawValue
            {
                let moring = object.isMorning
                if moring == Shift.Morning.rawValue
                {
                    let section = object.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "70")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "71")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "72")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "73")
                        }
                        else if time == "1:50 - 2:40"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "75")
                        }
                        else if time == "2:40 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "76")
                        }
                    }
                    else
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "60")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "61")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "62")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "63")
                        }
                        else if time == "1:50 - 2:40"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "65")
                        }
                        else if time == "2:40 - 3:30"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "66")
                        }
                    }
                }
            }
            else if day == Days.Friday.rawValue
            {
                let moring = object.isMorning
                if moring == Shift.Morning.rawValue
                {
                    let section = object.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "90")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "91")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "92")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "93")
                        }
                    }
                    else
                    {
                        let time = object.time_duration
                        // first value is row scond is column
                        if time == "9:00 - 9:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "80")
                        }
                        else if time == "10:00 - 10:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "81")
                        }
                        else if time == "11:00 - 11:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "82")
                        }
                        else if time == "12:00 - 12:50"
                        {
                            self.timeTable2DMutableDict.setValue(object, forKey: "83")
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func doneButtonPressed()
    {
        self.transparentView.isHidden = true
        self.timeTableInfoContainerViewView.isHidden = true
    }

}

extension FullTimeTableMorningViewController: GridViewDataSource, GridViewDelegate {
    func numberOfColumns(in gridView: GridView) -> Int {
        return 7
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
            
            if indexPath.column == 4
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
                if dict.day != ""
                {
                    let courseModel = dict.courseData
                    let courseNo = courseModel.number
                    var theoryStatus = String()
                    let isTheory = dict.isTheory
                    if isTheory == "Yes"
                    {
                        theoryStatus = " (T)"
                    }
                    else
                    {
                        theoryStatus = " (L)"
                    }
                    let teacherModel = dict.teacherData
                    let teacherName = teacherModel.name
                    let aray = teacherName.components(separatedBy: " ")
                    var teacherCode = String()
                    for each in aray
                    {
                        teacherCode = "\(teacherCode)\(each.first ?? Character(""))"
                    }
                    let course = courseNo
                    let cellString = course + theoryStatus + " (" + teacherCode + ")"
                    cell.configure(cellString)
                }
                
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
    
    func getObjectAtIntersectionOfDayAndTime(indexPath: IndexPath) -> TimeLocalModel
    {
        let key = String(indexPath.row) + String(indexPath.column)
        var model = TimeLocalModel()
        
        if (self.timeTable2DMutableDict[key] as? TimeLocalModel) != nil
        {
            model = self.timeTable2DMutableDict.value(forKey: key) as! TimeLocalModel
        }
        
        return model
    }
    
    func gridView(_ gridView: GridView, didScaleAt scale: CGFloat) {
        timeListView.contentScale(scale)
        dayView.contentScale(scale)
    }
    
    func gridView(_ gridView: GridView, didSelectRowAt indexPath: IndexPath) {
        gridView.deselectRow(at: indexPath)
        let dict = getObjectAtIntersectionOfDayAndTime(indexPath: indexPath)
        if dict.day != ""
        {
            setupCourseInfo(model: dict)
        }
    }
    
    func setupCourseInfo(model: TimeLocalModel)
    {
        self.transparentView.isHidden = false
        self.timeTableInfoContainerViewView.isHidden = false
        let courseModel = model.courseData
        let courseNo = courseModel.number
        self.courseNoLabel.text = courseNo
        let teacherModel = model.teacherData
        let teacherName = teacherModel.name
        self.courseInstructorLabel.text = teacherName
        self.courseCreditHoursLabel.text = courseModel.credit_hours
        self.courseNameLabel.text = courseModel.name
        let isTheory = model.isTheory
        if isTheory == "Yes"
        {
            if model.semester == Semester.Seventh.rawValue || model.semester == Semester.Eighth.rawValue
            {
                if model.program == Program.BSCS.rawValue{
                    if model.section == Section.SectionA.rawValue{
                        self.courseLocationLabel.text = "GF 22"
                    }
                    else{
                        self.courseLocationLabel.text = "GF 23"
                    }
                }
                else{
                    if model.section == Section.SectionA.rawValue{
                        self.courseLocationLabel.text = "GF 16"
                    }
                    else{
                        self.courseLocationLabel.text = "GF 17"
                    }
                }
            }
            else if model.semester == Semester.Fifth.rawValue || model.semester == Semester.Sixth.rawValue
            {
                if model.program == Program.BSCS.rawValue{
                    if model.section == Section.SectionA.rawValue{
                        self.courseLocationLabel.text = "FF 22"
                    }
                    else{
                        self.courseLocationLabel.text = "FF 23"
                    }
                }
                else{
                    if model.section == Section.SectionA.rawValue{
                        self.courseLocationLabel.text = "FF 16"
                    }
                    else{
                        self.courseLocationLabel.text = "FF 17"
                    }
                }
            }
            else{
                self.courseLocationLabel.text = "SF 16"
            }
        }
        else
        {
            if model.semester == Semester.Seventh.rawValue || model.semester == Semester.Eighth.rawValue
            {
                if model.program == Program.BSCS.rawValue{
                    if model.section == Section.SectionA.rawValue{
                        self.courseLocationLabel.text = "FF 01"
                    }
                    else{
                        self.courseLocationLabel.text = "FF 02"
                    }
                }
                else{
                    if model.section == Section.SectionA.rawValue{
                        self.courseLocationLabel.text = "GF 03"
                    }
                    else{
                        self.courseLocationLabel.text = "GF 04"
                    }
                }
            }
            else if model.semester == Semester.Fifth.rawValue || model.semester == Semester.Sixth.rawValue
            {
                if model.program == Program.BSCS.rawValue{
                    if model.section == Section.SectionA.rawValue{
                        self.courseLocationLabel.text = "FF 07"
                    }
                    else{
                        self.courseLocationLabel.text = "FF 08"
                    }
                }
                else{
                    if model.section == Section.SectionA.rawValue{
                        self.courseLocationLabel.text = "FF 09"
                    }
                    else{
                        self.courseLocationLabel.text = "FF 10"
                    }
                }
            }
            else{
                self.courseLocationLabel.text = "FF 12"
            }
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
        return 7//channels.count
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
                    cell.configure(self.channels.object(at: 7) as! String)
                }
                else if indexPath.column == 1
                {
                    cell.configure(self.channels.object(at: 8) as! String)
                }
                else if indexPath.column == 2
                {
                    cell.configure(self.channels.object(at: 9) as! String)
                }
                else if indexPath.column == 3
                {
                    cell.configure(self.channels.object(at: 10) as! String)
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
