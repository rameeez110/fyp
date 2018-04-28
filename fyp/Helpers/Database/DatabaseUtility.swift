//
//  DatabaseUtility.swift
//  fyp
//
//  Created by Rameez Hasan on 10/29/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import SQLite

class DataBaseUtility {
    
    var database: Connection!
    
    //MARK: Shared Instance
    
    static let sharedInstance : DataBaseUtility = {
        let instance = DataBaseUtility()
        return instance
    }()
    
    func copyDatabaseIntoDocumentsDirectory() {
        
        let fileManger = FileManager.default
        let doumentDirectoryPath = fileManger.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let documentsDirectory = doumentDirectoryPath.appendingPathComponent("fyp.db").path
        if (!FileManager.default.fileExists(atPath: documentsDirectory))
        {
            let sourcePath = Bundle.main.path(forResource: "fyp", ofType: "db")
            do {
                try fileManger.copyItem(atPath: sourcePath!, toPath: documentsDirectory)
            }
            catch let error {
                print(error)
            }
        }
        
        do {
            database = try Connection(documentsDirectory)
        }
        catch {
            print("Unable to open connection to database")
        }
    }
    
    // MARK: - create user flow
    
    func createCourse(courseModel: Course)
    {
        let course = Table("Course")
        
        let name = Expression<String?>("name")
        let number = Expression<String?>("number")
        let program = Expression<String?>("program")
        let server_id = Expression<String?>("server_id")
        let semester = Expression<String?>("semester")
        let status = Expression<String?>("status")
        let meta = Expression<String?>("meta")
        let code = Expression<String?>("code")
        let credit_hours = Expression<String?>("credit_hours")
        
        let courseName = courseModel.name
        let courseNumber = courseModel.number
        let courseProgram = courseModel.program
        let courseServerID = courseModel.server_id
        let courseSemester = courseModel.semester
        let courseStatus = courseModel.status
        let courseMeta = courseModel.meta
        let courseCode = courseModel.code
        let courseCreditHours = courseModel.credit_hours
        
        do {
            try database.run(course.insert(name <- courseName, number <- courseNumber ,program <- courseProgram, server_id <- courseServerID, semester <- courseSemester, status <- courseStatus ,meta <- courseMeta, code <- courseCode, credit_hours <- courseCreditHours))
        } catch let error as NSError {
            print("Unable to insert data to user table! \(error)")
        }
    }
    
    func createTeacher(teacherModel: TeacherLocalModel)
    {
        let teacher = Table("Teacher")
        
        let name = Expression<String?>("name")
        let serverId = Expression<String?>("server_id")
        let profilePic = Expression<String?>("profile_pic")
        let status = Expression<String?>("status")
        let availablity = Expression<String?>("availablity")
        let userId = Expression<String?>("user_id")
        let qualification = Expression<Int?>("qualification")
        
        let teacherName = teacherModel.name
        let teacherAvalblity = teacherModel.availablity
        let teacherPic = teacherModel.profilePicName
        let teacherStatus = teacherModel.status
        let teacherServerId = teacherModel.serverID
        let teacherUserId = teacherModel.userID
        let teacherQualification = teacherModel.qualification
        
        do {
            try database.run(teacher.insert(name <- teacherName,availablity <- teacherAvalblity,profilePic <- teacherPic,serverId <- teacherServerId,status <- teacherStatus,userId <- teacherUserId,qualification <- teacherQualification))
        } catch let error as NSError {
            print("Unable to insert data to user table! \(error)")
        }
    }
    
    // MARK: - get user flow
    
    func isCourseExisted() -> Bool {
        
        var courseStatus = false
        let course = Table("Course")
        let status = Expression<String?>("status")
        
        do {
            
            let query = course.filter(status == "YES")
            
            for _ in try database.prepare(query) {
                courseStatus = true
                break
            }
            
        } catch let error as NSError {
            print("Unable to select data from User table! \(error)")
        }
        
        return courseStatus
    }
    
    func isTeacherExisted() -> Bool {
        
        var teacherStatus = false
        let teacher = Table("Teacher")
        let status = Expression<String?>("status")
        
        do {
            
            let query = teacher.filter(status == "Yes")
            
            for _ in try database.prepare(query) {
                teacherStatus = true
                break
            }
            
        } catch let error as NSError {
            print("Unable to select data from User table! \(error)")
        }
        
        return teacherStatus
    }
    
    func getAllTeacher() -> NSMutableArray {
        
        let teacherArray = NSMutableArray()
        let teacher = Table("Teacher")
        
        let name = Expression<String?>("name")
        let serverId = Expression<String?>("server_id")
        let profilePic = Expression<String?>("profile_pic")
        let status = Expression<String?>("status")
        let availablity = Expression<String?>("availablity")
        let userId = Expression<String?>("user_id")
        let qualification = Expression<Int?>("qualification")
        let id = Expression<Int?>("id")
        
        do {
            
            let query = teacher.filter(status == "Yes")
            
            for teachers in try database.prepare(query) {
                let teacherLocalModel = TeacherLocalModel()
                teacherLocalModel.id = teachers[id]!
                teacherLocalModel.name = teachers[name]!
                teacherLocalModel.availablity = teachers[availablity]!
                teacherLocalModel.profilePicName = teachers[profilePic]!
                teacherLocalModel.serverID = teachers[serverId]!
                teacherLocalModel.qualification = teachers[qualification]!
                teacherLocalModel.userID = teachers[userId]!
                teacherLocalModel.status = teachers[status]!
                
                teacherArray.add(teacherLocalModel)
            }
            
        } catch let error as NSError {
            print("Unable to select data from User table! \(error)")
        }
        
        return teacherArray
    }
    
    func getTeacher(serverId: String) -> NSMutableArray {
        
        let teacherArray = NSMutableArray()
        let teacher = Table("Teacher")
        
        let name = Expression<String?>("name")
        let serverId = Expression<String?>("server_id")
        let profilePic = Expression<String?>("profile_pic")
        let status = Expression<String?>("status")
        let availablity = Expression<String?>("availablity")
        let userId = Expression<String?>("user_id")
        let qualification = Expression<Int?>("qualification")
        let id = Expression<Int?>("id")
        
        do {
            
            let query = teacher.filter(serverId == serverId)
            
            for teachers in try database.prepare(query) {
                let teacherLocalModel = TeacherLocalModel()
                teacherLocalModel.id = teachers[id]!
                teacherLocalModel.name = teachers[name]!
                teacherLocalModel.availablity = teachers[availablity]!
                teacherLocalModel.profilePicName = teachers[profilePic]!
                teacherLocalModel.serverID = teachers[serverId]!
                teacherLocalModel.qualification = teachers[qualification]!
                teacherLocalModel.userID = teachers[userId]!
                teacherLocalModel.status = teachers[status]!
                
                teacherArray.add(teacherLocalModel)
            }
            
        } catch let error as NSError {
            print("Unable to select data from User table! \(error)")
        }
        
        return teacherArray
    }
    
    func getCourse(serverId: String) -> NSMutableArray {
        
        let courseArray = NSMutableArray()
        let course = Table("Course")
        
        let name = Expression<String?>("name")
        let number = Expression<String?>("number")
        let course_program = Expression<String?>("program")
        let server_id = Expression<String?>("server_id")
        let semester = Expression<String?>("semester")
        let status = Expression<String?>("status")
        let meta = Expression<String?>("meta")
        let code = Expression<String?>("code")
        let credit_hours = Expression<String?>("credit_hours")
        let course_id = Expression<Int?>("id")
        
        do {
            
            let query = course.filter(server_id == serverId)
            
            for course in try database.prepare(query) {
                let courseModel = Course()
                courseModel.id = course[course_id]!
                courseModel.name = course[name]!
                courseModel.number = course[number]!
                courseModel.program = course[course_program]!
                courseModel.server_id = course[server_id]!
                courseModel.semester = course[semester]!
                courseModel.meta = course[meta]!
                courseModel.status = course[status]!
                courseModel.code = course[code]!
                courseModel.credit_hours = course[credit_hours]!
                
                courseArray.add(courseModel)
            }
            
        } catch let error as NSError {
            print("Unable to select data from User table! \(error)")
        }
        
        return courseArray
    }
    
    func getCourseProgramWise(program: String) -> NSMutableArray {
        
        let courseArray = NSMutableArray()
        let course = Table("Course")
        
        let name = Expression<String?>("name")
        let number = Expression<String?>("number")
        let course_program = Expression<String?>("program")
        let server_id = Expression<String?>("server_id")
        let semester = Expression<String?>("semester")
        let status = Expression<String?>("status")
        let meta = Expression<String?>("meta")
        let code = Expression<String?>("code")
        let credit_hours = Expression<String?>("credit_hours")
        let course_id = Expression<Int?>("id")
        
        do {
            
            let query = course.filter(course_program == program)
            
            for course in try database.prepare(query) {
                let courseModel = Course()
                courseModel.id = course[course_id]!
                courseModel.name = course[name]!
                courseModel.number = course[number]!
                courseModel.program = course[course_program]!
                courseModel.server_id = course[server_id]!
                courseModel.semester = course[semester]!
                courseModel.meta = course[meta]!
                courseModel.status = course[status]!
                courseModel.code = course[code]!
                courseModel.credit_hours = course[credit_hours]!
                
                courseArray.add(courseModel)
            }
            
        } catch let error as NSError {
            print("Unable to select data from User table! \(error)")
        }
        
        return courseArray
    }
    
    func getCourseSemesterWise(program: String , semester: String) -> NSMutableArray {
        
        let courseArray = NSMutableArray()
        let course = Table("Course")
        
        let name = Expression<String?>("name")
        let number = Expression<String?>("number")
        let course_program = Expression<String?>("program")
        let server_id = Expression<String?>("server_id")
        let course_semester = Expression<String?>("semester")
        let status = Expression<String?>("status")
        let meta = Expression<String?>("meta")
        let code = Expression<String?>("code")
        let credit_hours = Expression<String?>("credit_hours")
        let course_id = Expression<Int?>("id")
        
        do {
            
            let query = course.filter(course_program == program && course_semester == semester)
            
            for course in try database.prepare(query) {
                let courseModel = Course()
                courseModel.id = course[course_id]!
                courseModel.name = course[name]!
                courseModel.number = course[number]!
                courseModel.program = course[course_program]!
                courseModel.server_id = course[server_id]!
                courseModel.semester = course[course_semester]!
                courseModel.meta = course[meta]!
                courseModel.status = course[status]!
                courseModel.code = course[code]!
                courseModel.credit_hours = course[credit_hours]!
                
                courseArray.add(courseModel)
            }
            
        } catch let error as NSError {
            print("Unable to select data from User table! \(error)")
        }
        return courseArray
    }
}
