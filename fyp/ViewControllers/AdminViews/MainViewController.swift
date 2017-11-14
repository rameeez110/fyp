//
//  MainViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import Alamofire
import EZLoadingActivity

class MainViewController: UIViewController {
    
    @IBOutlet weak var createTimeTableButton: UIButton!
    @IBOutlet weak var showCourseButton: UIButton!
    @IBOutlet weak var showTimeTableButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loadAllCourses()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavigationBarUI()
    }
    
    func loadAllCourses()
    {
        let status = DataBaseUtility.sharedInstance.isCourseExisted()
        if status
        {
            print("course pare hen bhai")
        }
        else
        {
            EZLoadingActivity.show("Loading...", disableUI: false)
            callApiToGetAllCourse()
        }
    }
    
    func setupUI()
    {
        self.createTimeTableButton.layer.cornerRadius = 5
        self.createTimeTableButton.clipsToBounds = true
        
        self.showCourseButton.layer.cornerRadius = 5
        self.showCourseButton.clipsToBounds = true
    
        self.showTimeTableButton.layer.cornerRadius = 5
        self.showTimeTableButton.clipsToBounds = true
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.setHidesBackButton(true, animated:true)
    }
    
    @IBAction func createTimeTableButtonPressed()
    {
        let createTimeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "createTimeView") as! CreateTimeViewController
        self.navigationController!.pushViewController(createTimeViewController, animated:true)
    }
    
    @IBAction func showCourseButtonPressed()
    {
        let showCoursesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showCourses") as! ShowCoursesViewController
        self.navigationController!.pushViewController(showCoursesViewController, animated:true)
    }
    
    @IBAction func showTimeTableButtonPressed()
    {
        let showTimeTableViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "showTimeTableView") as! ShowTimeTableViewController
        self.navigationController!.pushViewController(showTimeTableViewController, animated:true)
    }
    
    // MARK: - Api Calling
    
    func callApiToGetAllCourse()
    {
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            ]
        performRequestToGetAllCourse(parameters: parameters)
    }
    
    func performRequestToGetAllCourse(parameters: Parameters)
    {
        Alamofire.request("https://rameeez110.000webhostapp.com/fyp/web/index.php/webservice/getallcourse/", parameters: parameters).responseData { response in
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                EZLoadingActivity.hide(true, animated: true)
//                print(cardJsonObject as Any)
                
                if cardJsonObject != nil{
                    
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        let coversDict = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        
                        if result == "SUCCESS"
                        {
                            for object in coversDict
                            {
                                let course = object as! NSDictionary
                                let courseModel = Course()
                                courseModel.name = course.value(forKey: "name") as! String
                                courseModel.number = course.value(forKey: "number") as! String
                                courseModel.program = course.value(forKey: "program") as! String
                                courseModel.code = course.value(forKey: "code") as! String
                                courseModel.meta = course.value(forKey: "meta") as! String
                                courseModel.semester = course.value(forKey: "semester") as! String
                                courseModel.status = course.value(forKey: "status") as! String
                                courseModel.credit_hours = course.value(forKey: "credit_hours") as! String
                                courseModel.server_id = course.value(forKey: "id") as! String
                                
                                DataBaseUtility.sharedInstance.createCourse(courseModel: courseModel)
                            }
                        }
                    }
                    else
                    {
                        let alert = UIAlertController(title: "No courses found!", message: nil, preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "No internet Connection!", message: "Please check your internet connection.", preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                    }
                    alert.addAction(firstAction)
                    self.present(alert, animated: true, completion:nil)
                }
            }
        }
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
