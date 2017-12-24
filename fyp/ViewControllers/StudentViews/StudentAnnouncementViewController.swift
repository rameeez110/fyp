//
//  StudentAnnouncementViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

class StudentAnnouncementViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var studentAnnouncementTableView: UITableView!
    
    var announcementMutableArray = NSMutableArray()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarUI()
        callApiToGetAllAnnouncements()
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        let navigationBarLabel =  UILabel()
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.textAlignment = .center
        navigationBarLabel.text = "Announcements"
        self.navigationItem.titleView = navigationBarLabel
    }
    
    // MARK: - Api Calling
    
    func callApiToGetAllAnnouncements()
    {
        EZLoadingActivity.show("Loading...", disableUI: false)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            ]
        performRequestToGetAllAnnouncements(parameters: parameters)
    }
    
    func performRequestToGetAllAnnouncements(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.GetAllAnnouncement, parameters: parameters).responseData { response in
            
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
//                print(cardJsonObject as Any)
                
                EZLoadingActivity.hide(true, animated: true)
                
                if (cardJsonObject?.value(forKey: "data")) != nil
                {
                    if let dataDict = cardJsonObject?.value(forKey: "data")
                    {
                        let followArray = dataDict as! NSArray
                        let result = cardJsonObject?.value(forKey: "response") as! String
                        
                        if result == "SUCCESS"
                        {
                            for object in followArray
                            {
                                let objectDict = object as! NSDictionary
                                self.announcementMutableArray.add(objectDict)
                            }
                            self.studentAnnouncementTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    // MARK: - Table View Delegate And Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.announcementMutableArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let announcementCell = tableView.dequeueReusableCell(withIdentifier: "announcementCell", for: indexPath) as! AnnouncementTableViewCell
        
        tableView.tableFooterView = UIView()
        
        let announcementDict = self.announcementMutableArray.object(at: indexPath.row) as! NSDictionary
        
        let objectArray = announcementDict.value(forKey: "TeacherData") as! NSArray
        let teacherDict = objectArray.object(at: 0) as! NSDictionary

        if let description = announcementDict.value(forKey: "description") as? String{
            announcementCell.descriptionLabel.text = description
        }
        
        if let name = teacherDict.value(forKey: "name") as? String{
            announcementCell.titleLabel.text = name
        }
        
        announcementCell.pofilePicImageView.layer.cornerRadius = announcementCell.pofilePicImageView.frame.size.width/2
        announcementCell.pofilePicImageView.clipsToBounds = true
        
        return announcementCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        editingIndexPath = indexPath as NSIndexPath
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
