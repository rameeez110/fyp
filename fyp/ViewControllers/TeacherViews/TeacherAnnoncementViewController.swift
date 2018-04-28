//
//  TeacherAnnoncementViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import EZLoadingActivity
import Alamofire

class TeacherAnnoncementViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource , UITextViewDelegate{
    
    @IBOutlet weak var teacherAnnoncementTableView: UITableView!
    
    @IBOutlet weak var addAnnoncementContainerView: UIView!
    
    @IBOutlet weak var announcementTextView: UITextView!
    
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var announceButton: UIButton!
    
    var announcementMutableArray = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
        setNavigationBarUI()
        callApiToGetAllAnnouncements()
    }
    
    // MARK: - View UI
    
    func setupUI()
    {
        self.announceButton.layer.cornerRadius = 10
        self.announceButton.clipsToBounds = true
        
        self.cancelButton.layer.cornerRadius = 15
        self.cancelButton.clipsToBounds = true
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
        
        let navigationBarRightButton =  UIButton()
        navigationBarRightButton.setTitle("+", for: .normal)
        navigationBarRightButton.titleLabel?.font = UIFont.systemFont(ofSize: 25)
        navigationBarRightButton.titleLabel?.textColor = UIColor.white
        navigationBarRightButton.frame = CGRect(x: 0, y: 0, width: 60, height: 30)
        navigationBarRightButton.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
        let rightBarButton = UIBarButtonItem()
        rightBarButton.customView = navigationBarRightButton
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    @objc func addButtonPressed(_ sender: UIBarButtonItem)
    {
        self.addAnnoncementContainerView.isHidden = false
    }
    
    // MARK: - IBActions
    
    @IBAction func announceButtonPressed()
    {
        self.addAnnoncementContainerView.isHidden = true
        EZLoadingActivity.show("Adding ..", disableUI: false)
        callApiToAddAnnouncement()
    }
    
    @IBAction func cancelButtonPressed()
    {
        self.addAnnoncementContainerView.isHidden = true
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
                            self.teacherAnnoncementTableView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    func callApiToAddAnnouncement()
    {
        let teacherID = UserDefaults.standard.string(forKey: URLConstants.UserDefaults.LoggedInTeacherID)
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "teacher_id": teacherID!,
            "description": self.announcementTextView.text,
            "meta": "test announcement",
            ]
        performRequestToAddTime(parameters: parameters)
    }
    
    func performRequestToAddTime(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.AddAnnouncement, parameters: parameters).responseData { response in
            if let data = response.data
            {
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                print(cardJsonObject as Any)
                EZLoadingActivity.hide(true, animated: true)
                if (cardJsonObject?.value(forKey: "response")) != nil
                {
                    //                        print(dataDict as Any)
                    let result = cardJsonObject?.value(forKey: "response") as! String
                    
                    if result == "SUCCESS"
                    {
                        let alert = UIAlertController(title: "Announcement added succesfuly!", message: nil, preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
                    else
                    {
                        let alert = UIAlertController(title: "Announcement not added succesfuly!", message: nil, preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "Something went wrong!", message: "Please check your internet connection.", preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                    }
                    alert.addAction(firstAction)
                    self.present(alert, animated: true, completion:nil)
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
    
    func textViewDidEndEditing(_ textView: UITextView){
        self.view.endEditing(true)
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
