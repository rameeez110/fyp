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

struct Slot {
    let minutes: Int
    let startAt: Int
    let title: String
    let detail: String
}

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
    
    @IBOutlet weak var courseNoLabel: UILabel!
    @IBOutlet weak var courseNameLabel: UILabel!
    @IBOutlet weak var courseInstructorLabel: UILabel!
    @IBOutlet weak var courseCreditHoursLabel: UILabel!
    @IBOutlet weak var courseLocationLabel: UILabel!
    
    public var timeTableMutableArray = NSMutableArray()
    var timeTable2DMutableDict = NSMutableDictionary()
    
    let timeArray = NSMutableArray()
    var timeListDataSource: TimeListDataSource?
    private let dayDataSource = DayGridViewDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        fillTimeArray()
        fillTimeTable2DArray()
        
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
    
    func fillTimeArray()
    {
        self.timeArray.add("3:30 - 5:10")
        self.timeArray.add("5:10 - 6:50")
        self.timeArray.add("6:50 - 8:30")
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
                if moring == "Evening"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "10")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "11")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "12")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "00")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "01")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "02")
                        }
                    }
                }
            }
            else if day == "Tuesday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Evening"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "30")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "31")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "32")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "20")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "21")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "22")
                        }
                    }
                }
            }
            else if day == "Wednesday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Evening"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "50")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "51")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "52")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "40")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "41")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "42")
                        }
                    }
                }
            }
            else if day == "Thursday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Evening"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "70")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "71")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "72")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "60")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "61")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "62")
                        }
                    }
                }
            }
            else if day == "Friday"
            {
                let moring = dict.value(forKey: "is_morning") as! String
                if moring == "Evening"
                {
                    let section = dict.value(forKey: "section") as! String
                    if section == "Section B"
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        // first value is row scond is column
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "90")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "91")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "92")
                        }
                    }
                    else
                    {
                        let time = dict.value(forKey: "time_duration") as! String
                        if time == "3:30 - 5:10"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "80")
                        }
                        else if time == "5:10 - 6:50"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "81")
                        }
                        else if time == "6:50 - 8:30"
                        {
                            self.timeTable2DMutableDict.setValue(dict, forKey: "82")
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

extension FullTimeTableViewController: GridViewDataSource, GridViewDelegate {
    func numberOfColumns(in gridView: GridView) -> Int {
        return 3
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
    
    func getObjectAtIntersectionOfDayAndTime(indexPath: IndexPath) -> NSDictionary
    {
        let key = String(indexPath.row) + String(indexPath.column)
        var dict = NSDictionary()
        
        if (self.timeTable2DMutableDict[key] as? NSDictionary) != nil
        {
            dict = self.timeTable2DMutableDict.value(forKey: key) as! NSDictionary
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
            self.transparentView.isHidden = false
            self.timeTableInfoContainerViewView.isHidden = false
            let courseArray = dict.value(forKey: "CourseData") as! NSArray
            let courseDict = courseArray.object(at: 0) as! NSDictionary
            let courseNo = courseDict.value(forKey: "number")
            self.courseNoLabel.text = courseNo as? String
            let techerArray = dict.value(forKey: "TeacherData") as! NSArray
            let techerDict = techerArray.object(at: 0) as! NSDictionary
            let teacherName = techerDict.value(forKey: "name") as! String
            self.courseInstructorLabel.text = teacherName
            self.courseCreditHoursLabel.text = (courseDict.value(forKey: "credit_hours") as! String)
            self.courseNameLabel.text = courseDict.value(forKey: "name") as? String
            let isTheory = dict.value(forKey: "is_theory") as! String
            if isTheory == "Thoery"
            {
                self.courseLocationLabel.text = "GF 22"
            }
            else
            {
                self.courseLocationLabel.text = "FF 01"
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
//    let channels: [String]
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
