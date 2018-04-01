//
//  TeacherAttachmentViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/22/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class TeacherAttachmentViewController: UIViewController ,UITableViewDelegate , UITableViewDataSource{
    
    @IBOutlet weak var teacherAttachmentTableView: UITableView!
    
    var imageArray = [String]()
    var descriptionArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setNavigationBarUI()
        imageArray.append("admission")
        imageArray.append("prospectus")
        descriptionArray.append("Admission advertisement")
        descriptionArray.append("Admission prospectus of 2018")
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
        navigationBarLabel.text = "Feeds"
        self.navigationItem.titleView = navigationBarLabel
    }
    
    // MARK: - Table View Delegate And Data Source
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2//self.timeTitleLabelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let attachmentCell = tableView.dequeueReusableCell(withIdentifier: "attachmentCell", for: indexPath) as! AttachmentTableViewCell
        
        attachmentCell.attachmentImageView.image = UIImage(named: self.imageArray[indexPath.row])
        attachmentCell.descriptionLabel.text = self.descriptionArray[indexPath.row]
        tableView.tableFooterView = UIView()
        
        return attachmentCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let attachmentDetailView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "attachmentDetailView") as! AttachmentDetailViewController
        attachmentDetailView.teacherName = "teacher 4"
        attachmentDetailView.descriptionText = self.descriptionArray[indexPath.row]
        if indexPath.row == 1
        {
            attachmentDetailView.pdfName = ".pdf"
        }
        self.navigationController!.pushViewController(attachmentDetailView, animated:true)
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
