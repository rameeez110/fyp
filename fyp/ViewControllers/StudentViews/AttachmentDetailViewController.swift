//
//  AttachmentDetailViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 12/24/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class AttachmentDetailViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var attachmentImageView: UIImageView!
    
    public var teacherName = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setNavigationBarUI()
    }
    
    // MARK: - Navigation bar Ui
    
    func setNavigationBarUI()
    {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.setHidesBackButton(false, animated:true)
        
        let navigationBarLabel =  UILabel()
        navigationBarLabel.frame = CGRect(x: 0, y: 0, width: 200, height: 30)
        navigationBarLabel.textColor = UIColor(red: 201/255, green: 222/255, blue: 224/255, alpha: 1)
        navigationBarLabel.backgroundColor = UIColor.clear
        navigationBarLabel.textAlignment = .center
        navigationBarLabel.text = self.teacherName
        self.navigationItem.titleView = navigationBarLabel
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
