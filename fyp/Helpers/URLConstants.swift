//
//  URLConstants.swift
//  
//
//  Created by Rameez Hasan on 12/10/17.
//

import UIKit

class URLConstants: NSObject {
    
    struct APPURL {
        
        private struct Domains {
            static let DevelopmentServer = "https://rameeez110.000webhostapp.com"
            static let LocalServer = "http://104.131.71.64"
            //"https://rameeez110.000webhostapp.com/fyp/web/index.php/webservice/getallteachers/"
        }
        
        private static let Domain = Domains.DevelopmentServer
        private static let BaseURL = Domain + "/fyp/web/"
        private static let RestURL = "index.php/webservice/"
        
        static var ServerImageURL: String{
            return BaseURL
        }
        
        // MARK: User Profile
        
        static var UserLogin: String {
            return BaseURL + RestURL + "validateuser/"
        }
        
        static var UserRegister: String {
            return BaseURL + RestURL + "registeruser/"
        }
        
        static var ChangePassword: String {
            return BaseURL + RestURL + "resetpassword/"
        }
        
        static var GetUserProfile: String {
            return BaseURL + RestURL + "validateuser/"
        }
        
        static var ForgetPassword: String {
            return BaseURL + RestURL + "forgetpassword/"
        }
        
        // MARK: Profile
        
        static var EditUserProfilePic: String{
            return BaseURL + RestURL + "edituserprofilepic/"
        }
        
        // MARK: Teachers
        
        static var GetAllTeacher: String{
            return BaseURL + RestURL + "getallteachers/"
        }
        
        // MARK: Courses
        
        static var AddCourse: String{
            return BaseURL + RestURL + "addcourse/"
        }
        
        static var GetAllCourses: String{
            return BaseURL + RestURL + "getallcourse/"
        }
        
        static var GetCourseProgramWise: String{
            return BaseURL + RestURL + "getallcourseprogramwise/"
        }
        
        // MARK: Follow
        
        static var AddFollow: String{
            return BaseURL + RestURL + "addfollow/"
        }
        
        static var GetAllFollowers: String{
            return BaseURL + RestURL + "getallfollowers/"
        }
        
        static var GetAllFollows: String{
            return BaseURL + RestURL + "getallfollows/"
        }
        
        // MARK: Time
        
        static var AddTime: String{
            return BaseURL + RestURL + "addfollow/"
        }
        
        static var GetTimeCourseWise: String{
            return BaseURL + RestURL + "gettimecoursewise/"
        }
        
        static var GetTimeTeacherWise: String{
            return BaseURL + RestURL + "gettimeteacherwise/"
        }
        
        static var GetTimeMorningEveningWise: String{
            return BaseURL + RestURL + "gettimemorningeveningwise/"
        }
        
        static var GetFullTimeTable: String{
            return BaseURL + RestURL + "gettimetable/"
        }
        
        // MARK: Announcement
        
        static var AddAnnouncement: String{
            return BaseURL + RestURL + "addannouncement/"
        }
        
        static var GetAllAnnouncement: String{
            return BaseURL + RestURL + "getallannouncement/"
        }
        
        // MARK: Attachment
        
        static var AddAttachment: String{
            return BaseURL + RestURL + "addattachment/"
        }
        
        static var GetTeacherAttachment: String{
            return BaseURL + RestURL + "getteacherattachment/"
        }
        
        static var GetAttachment: String{
            return BaseURL + RestURL + "getattachment/"
        }
    }
    
    struct UserDefaults{
        
        static var LoggedInUserId: String{
            return "LoggedInUserId"
        }
        
        static var LoggedInUserRoleId: String{
            return "LoggedInUserRoleId"
        }
        
        static var LoggedInUserEmail: String{
            return "LoggedInUserEmail"
        }
        
        static var LoggedInUserPassword: String{
            return "LoggedInUserPassword"
        }
        
        // MARK: Teacher
        
        static var LoggedInTeacherName: String{
            return "LoggedInTeacherName"
        }
        
        static var LoggedInTeacherPicName: String{
            return "LoggedInTeacherPicName"
        }
        
        static var LoggedInTeacherID: String{
            return "LoggedInTeacherID"
        }
        
        // MARK: Student
        
        static var LoggedInStudentName: String{
            return "LoggedInStudentName"
        }
        
        static var LoggedInStudentID: String{
            return "LoggedInStudentID"
        }
        
        static var LoggedInStudentPicName: String{
            return "LoggedInStudentPicName"
        }
        
    }
    
}
