//
//  Time.swift
//  fyp
//
//  Created by Rameez Hasan on 12/10/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class Time{
    var id = Int()
    var status = String()
    var day = String()
    var teacherID = String()
    var courseID = String()
    var year = String()
    var time_duration = String()
    var semester = String()
    var section = String()
    var meta = String()
    var isTheory = String()
    var isMorning = String()
    var teacherData = Teacher()
    var courseData = Course()
    var program = String()
}

class TimeLocalModel{
    var id = Int()
    var status = String()
    var day = String()
    var teacherID = String()
    var courseID = String()
    var year = String()
    var time_duration = String()
    var semester = String()
    var section = String()
    var meta = String()
    var isTheory = String()
    var isMorning = String()
    var teacherData = TeacherLocalModel()
    var courseData = Course()
    var program = String()
    
    var description: String {
        return "day : \(self.day) \n teacherID : \(self.teacherID) \n courseID : \(self.courseID) \n time_duration : \(self.time_duration) \n isTheory : \(self.isTheory) \n section : \(self.section)"
    }
    
}

