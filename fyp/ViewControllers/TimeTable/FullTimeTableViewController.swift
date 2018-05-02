//
//  FullTimeTableViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/15/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import G3GridView
import Foundation

extension UIColor {
    fileprivate convenience init(hex: Int, alpha: CGFloat = 1) {
        let red = CGFloat((hex & 0xFF0000) >> 16) / 255
        let green = CGFloat((hex & 0x00FF00) >> 8 ) / 255
        let blue = CGFloat((hex & 0x0000FF) >> 0 ) / 255
        
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

class FullTimeTableViewController: UIViewController {
    
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
    
    let timeArray = NSMutableArray()
    var timeListDataSource: TimeListDataSource?
    private let dayDataSource = DayGridViewDataSource()
    public var titleString = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigationBarUI()
        fillTimeArray()
        fillTimeTable2DArray()
//        fillTitle()
        
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
//        self.navigationController?.navigationItem.setHidesBackButton(false, animated: true)
        
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
        self.timeArray.add("3:30 - 4:20")
        self.timeArray.add("4:20 - 5:10")
        self.timeArray.add("5:10 - 6:00")
        self.timeArray.add("6:00 - 6:50")
        self.timeArray.add("6:50 - 7:40")
        self.timeArray.add("7:40 - 8:30")
    }
    
    func fillTimeTable2DArray()
    {
        for eachTime in self.timeTableArray{
            let day = eachTime.day
            if day == Days.Monday.rawValue
            {
                let moring = eachTime.isMorning
                if moring == Shift.Evening.rawValue
                {
                    let section = eachTime.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = eachTime.time_duration
                        // first value is row second is column
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "10")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "11")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "12")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "13")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "14")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "15")
                        }
                    }
                    else
                    {
                        let time = eachTime.time_duration
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "00")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "01")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "02")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "03")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "04")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "05")
                        }
                    }
                }
            }
            else if day == Days.Tuesday.rawValue
            {
                let moring = eachTime.isMorning
                if moring == Shift.Evening.rawValue
                {
                    let section = eachTime.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = eachTime.time_duration
                        // first value is row second is column
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "30")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "31")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "32")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "33")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "34")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "35")
                        }
                    }
                    else
                    {
                        let time = eachTime.time_duration
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "20")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "21")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "22")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "23")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "24")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "25")
                        }
                    }
                }
            }
            else if day == Days.Wednesday.rawValue
            {
                let moring = eachTime.isMorning
                if moring == Shift.Evening.rawValue
                {
                    let section = eachTime.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = eachTime.time_duration
                        // first value is row second is column
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "50")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "51")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "52")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "53")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "54")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "55")
                        }
                    }
                    else
                    {
                        let time = eachTime.time_duration
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "40")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "41")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "42")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "43")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "44")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "45")
                        }
                    }
                }
            }
            else if day == Days.Thursday.rawValue
            {
                let moring = eachTime.isMorning
                if moring == Shift.Evening.rawValue
                {
                    let section = eachTime.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = eachTime.time_duration
                        // first value is row second is column
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "70")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "71")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "72")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "73")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "74")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "75")
                        }
                    }
                    else
                    {
                        let time = eachTime.time_duration
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "60")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "61")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "62")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "63")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "64")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "65")
                        }
                    }
                }
            }
            else if day == Days.Friday.rawValue
            {
                let moring = eachTime.isMorning
                if moring == Shift.Evening.rawValue
                {
                    let section = eachTime.section
                    if section == Section.SectionB.rawValue
                    {
                        let time = eachTime.time_duration
                        // first value is row second is column
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "90")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "91")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "92")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "93")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "94")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "95")
                        }
                    }
                    else
                    {
                        let time = eachTime.time_duration
                        if time == "3:30 - 4:20"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "80")
                        }
                        else if time == "4:20 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "81")
                        }
                        else if time == "5:10 - 6:00"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "82")
                        }
                        else if time == "6:00 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "83")
                        }
                        else if time == "6:50 - 7:40"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "84")
                        }
                        else if time == "7:40 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(eachTime, forKey: "85")
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

extension FullTimeTableViewController: GridViewDataSource, GridViewDelegate {
    func numberOfColumns(in gridView: GridView) -> Int {
        return 6
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
            self.transparentView.isHidden = false
            self.timeTableInfoContainerViewView.isHidden = false
            let courseModel = dict.courseData
            let courseNo = courseModel.number
            self.courseNoLabel.text = courseNo
            let teacherModel = dict.teacherData
            let teacherName = teacherModel.name
            self.courseInstructorLabel.text = teacherName
            self.courseCreditHoursLabel.text = courseModel.credit_hours
            self.courseNameLabel.text = courseModel.name
            let isTheory = dict.isTheory
            if isTheory == "Yes"
            {
                if dict.semester == Semester.Seventh.rawValue || dict.semester == Semester.Eighth.rawValue
                {
                    if dict.program == Program.BSCS.rawValue{
                        if dict.section == Section.SectionA.rawValue{
                            self.courseLocationLabel.text = "GF 22"
                        }
                        else{
                            self.courseLocationLabel.text = "GF 23"
                        }
                    }
                    else{
                        if dict.section == Section.SectionA.rawValue{
                            self.courseLocationLabel.text = "GF 16"
                        }
                        else{
                            self.courseLocationLabel.text = "GF 17"
                        }
                    }
                }
                else if dict.semester == Semester.Fifth.rawValue || dict.semester == Semester.Sixth.rawValue
                {
                    if dict.program == Program.BSCS.rawValue{
                        if dict.section == Section.SectionA.rawValue{
                            self.courseLocationLabel.text = "FF 22"
                        }
                        else{
                            self.courseLocationLabel.text = "FF 23"
                        }
                    }
                    else{
                        if dict.section == Section.SectionA.rawValue{
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
                if dict.semester == Semester.Seventh.rawValue || dict.semester == Semester.Eighth.rawValue
                {
                    if dict.program == Program.BSCS.rawValue{
                        if dict.section == Section.SectionA.rawValue{
                            self.courseLocationLabel.text = "FF 01"
                        }
                        else{
                            self.courseLocationLabel.text = "FF 02"
                        }
                    }
                    else{
                        if dict.section == Section.SectionA.rawValue{
                            self.courseLocationLabel.text = "GF 03"
                        }
                        else{
                            self.courseLocationLabel.text = "GF 04"
                        }
                    }
                }
                else if dict.semester == Semester.Fifth.rawValue || dict.semester == Semester.Sixth.rawValue
                {
                    if dict.program == Program.BSCS.rawValue{
                        if dict.section == Section.SectionA.rawValue{
                            self.courseLocationLabel.text = "FF 07"
                        }
                        else{
                            self.courseLocationLabel.text = "FF 08"
                        }
                    }
                    else{
                        if dict.section == Section.SectionA.rawValue{
                            self.courseLocationLabel.text = "GF 09"
                        }
                        else{
                            self.courseLocationLabel.text = "GF 10"
                        }
                    }
                }
                else{
                    self.courseLocationLabel.text = "FF 11"
                }
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        timeListView.contentOffset.x = scrollView.contentOffset.x
        dayView.contentOffset.y = scrollView.contentOffset.y
    }
}

final class DayGridViewDataSource: NSObject, GridViewDataSource, GridViewDelegate {
    
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

final class TimeListDataSource: NSObject, GridViewDataSource, GridViewDelegate {
    var channels = NSMutableArray()
    
    init(channels: NSMutableArray) {
        self.channels = channels
    }
    
    func numberOfColumns(in gridView: GridView) -> Int {
        return channels.count
    }
    
    func gridView(_ gridView: GridView, numberOfRowsInColumn column: Int) -> Int {
        return 1
    }
    
    func gridView(_ gridView: GridView, cellForRowAt indexPath: IndexPath) -> GridViewCell {
        let cell = gridView.dequeueReusableCell(withReuseIdentifier: "TimeGridViewCell", for: indexPath)
        if let cell = cell as? TimeGridViewCell {
            cell.configure(self.channels.object(at: indexPath.column) as! String)
        }
        
        return cell
    }
}
