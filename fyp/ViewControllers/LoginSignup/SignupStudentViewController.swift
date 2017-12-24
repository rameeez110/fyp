//
//  SignupStudentViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/14/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import Alamofire
import EZLoadingActivity

class SignupStudentViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDelegate , UIPickerViewDataSource{
    
    @IBOutlet weak var profilePicAlphaView: UIView!
    
    @IBOutlet weak var profilePicStackView: UIStackView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var epNumTextField: UITextField!
    @IBOutlet weak var enrollmentNumTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var degreeProgramButton: UIButton!
    @IBOutlet weak var sectionButton: UIButton!
    @IBOutlet weak var morningEveningButton: UIButton!
    
    // UIPicker Flow
    @IBOutlet weak var pickerDoneButton: UIButton!
    @IBOutlet weak var descriptionPickerView: UIPickerView!
    
    var pickerDataArray = NSMutableArray()
    
    //Image Picekr
    var imagePicker = UIImagePickerController()
    
    var imageName = String()
    var stringContainingImageData = String()
    var section = String()
    var cgpa = String()
    var program = String()
    var isMorning = String()
    
    var selectedPickerIndex = Int()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - View UI
    
    func setupUI()
    {
        self.createButton.layer.cornerRadius = 10
        self.createButton.clipsToBounds = true
        
        self.degreeProgramButton.layer.cornerRadius = 10
        self.degreeProgramButton.clipsToBounds = true
        
        self.sectionButton.layer.cornerRadius = 10
        self.sectionButton.clipsToBounds = true
        
        self.morningEveningButton.layer.cornerRadius = 10
        self.morningEveningButton.clipsToBounds = true
        
        self.profilePicButton.layer.cornerRadius = self.profilePicButton.frame.size.width/2
        self.profilePicButton.clipsToBounds = true
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonPressed()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonPressed()
    {
        //callApiTocreate
        if self.usernameTextField.text == "" || self.emailTextField.text == ""
        || self.passwordTextField.text == "" || self.enrollmentNumTextField.text == ""
        || self.epNumTextField.text == "" || self.yearTextField.text == ""
        || self.section == "" || self.program == "" || self.isMorning == ""
        {
            let alert = UIAlertController(title: "Required Fields can't be empty!", message: "Please fill all required field to signup.", preferredStyle: .alert) // 1
            let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
            }
            alert.addAction(firstAction)
            self.present(alert, animated: true, completion:nil)
        }
        else
        {
            EZLoadingActivity.show("Signing Up..", disableUI: false)
            callApiToRegister()
        }
    }
    
    @IBAction func profilePicButtonPressed()
    {
        self.profilePicAlphaView.isHidden = false
        self.profilePicStackView.isHidden = false
    }
    
    @IBAction func cancelButtonPressed()
    {
        self.profilePicAlphaView.isHidden = true
        self.profilePicStackView.isHidden = true
    }
    
    @IBAction func photoButtonPressed()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.savedPhotosAlbum)
        {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum;
            self.imagePicker.allowsEditing = false
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    @IBAction func cameraButtonPressed()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        {
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.camera;
            self.imagePicker.allowsEditing = false
            self.imagePicker.delegate = self
            self.present(self.imagePicker, animated: true, completion: nil)
        }
    }
    
    //pickerData = ["home", "work", "fax","mobile"]
    
    @IBAction func degreeProgramButtonPressed()
    {
        self.profilePicAlphaView.isHidden = false
        selectedPickerIndex = 0
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add("BSCS")
        array.add("BSSE")
        array.add("MCS")
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Program", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func sectionButtonPressed()
    {
        self.profilePicAlphaView.isHidden = false
        selectedPickerIndex = 0
        
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add("Section A")
        array.add("Section B")
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Section", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func morningEveningButtonPressed()
    {
        self.profilePicAlphaView.isHidden = false
        selectedPickerIndex = 0
        
        let array = NSMutableArray()
        self.pickerDataArray = NSMutableArray()
        array.add("Morning")
        array.add("Evening")
        for data in array
        {
            let dict = NSMutableDictionary()
            dict.setValue("Morning/Evening", forKey: "Index")
            dict.setValue(data as! String, forKey: "Data")
            self.pickerDataArray.add(dict)
        }
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func pickerDoneButtonPressed()
    {
        self.profilePicAlphaView.isHidden = true
        
        let nameDict = self.pickerDataArray.object(at: selectedPickerIndex) as! NSMutableDictionary
        let index = nameDict.value(forKey: "Index") as! String
        if index == "Program"
        {
            self.degreeProgramButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            self.program = nameDict.value(forKey: "Data") as! String
        }
        else if index == "Morning/Evening"
        {
            self.morningEveningButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            self.isMorning = nameDict.value(forKey: "Data") as! String
        }
        else if index == "Section"
        {
            self.sectionButton.setTitle(nameDict.value(forKey: "Data") as? String, for: .normal)
            self.section = nameDict.value(forKey: "Data") as! String
        }
    }
    
    // MARK: - Api Calling
    
    func callApiToRegister()
    {
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "name": self.usernameTextField.text!,
            "password": self.passwordTextField.text!,
            "email": self.emailTextField.text!,
            "profile_pic": self.stringContainingImageData,
            "ep_num": self.epNumTextField.text!,
            "enrolment_no": self.enrollmentNumTextField.text!,
            "degree_program": self.program,
            "section": self.section,
            "year": self.yearTextField.text!,
            "cgpa": "2.9",
            "role_id": "3",
            ]
        performRequestToRegister(parameters: parameters)
    }
    
    func performRequestToRegister(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.UserRegister , parameters: parameters).responseData { response in
            if let data = response.data
            {
                let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                
                EZLoadingActivity.hide(true, animated: true)
                let cardJsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as! NSDictionary
                
                print(cardJsonObject as Any)
                if let dataDict = cardJsonObject?.value(forKey: "data")
                {
                    let signupDict = dataDict as! NSDictionary
                    let result = cardJsonObject?.value(forKey: "response") as! String
                    
                    if result == "SUCCESS"
                    {
                        let userID = signupDict.value(forKey: "userID") as! Int
                        let studentID = signupDict.value(forKey: "studentID") as! Int

                        UserDefaults.standard.set(self.emailTextField.text!, forKey: URLConstants.UserDefaults.LoggedInUserEmail)
                        UserDefaults.standard.set(self.usernameTextField.text!, forKey: URLConstants.UserDefaults.LoggedInStudentName)
                        UserDefaults.standard.set(self.passwordTextField.text!, forKey: URLConstants.UserDefaults.LoggedInUserPassword)
                        UserDefaults.standard.set(String(userID), forKey: URLConstants.UserDefaults.LoggedInUserId)
                        UserDefaults.standard.set(String(studentID), forKey: URLConstants.UserDefaults.LoggedInStudentID)
                        UserDefaults.standard.set("2", forKey: URLConstants.UserDefaults.LoggedInUserRoleId)
                        if self.imageName != ""
                        {
                            UserDefaults.standard.set(self.imageName, forKey: URLConstants.UserDefaults.LoggedInStudentPicName)
                        }

                        let tabBarController: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "StudentTabBarController") as! UITabBarController
                        self.navigationController?.pushViewController(tabBarController, animated: true)
                    }
                    else
                    {
                        let alert = UIAlertController(title: "User not created!", message: "Something went wrong please try again later or check your internet connection.", preferredStyle: .alert) // 1
                        let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                        }
                        alert.addAction(firstAction)
                        self.present(alert, animated: true, completion:nil)
                    }
                }
                else
                {
                    let alert = UIAlertController(title: "User not created!", message: "Something went wrong please try again later or check your internet connection.", preferredStyle: .alert) // 1
                    let firstAction = UIAlertAction(title: "Ok", style: .default) { (alert: UIAlertAction!) -> Void in
                    }
                    alert.addAction(firstAction)
                    self.present(alert, animated: true, completion:nil)
                }
            }
        }
    }
    
    // MARK: - Text Field Delegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.isFirstResponder
        {
            textField.resignFirstResponder()
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool
    {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool
    {
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField)
    {
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    // MARK: - Image picker Delegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        {
            let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            // create a name for your image
            
            let imageData = UIImagePNGRepresentation(pickedImage)//pickedImage.jpeg(.lowest)
            
            let strBase64 = imageData?.base64EncodedString(options: .lineLength64Characters)
            stringContainingImageData = strBase64!
            let uuid = NSUUID().uuidString
            
            let uniqueStringArray = uuid.components(separatedBy: "-")
            
            imageName = uniqueStringArray.first! + ".jpg"
            
            let fileURL = documentsDirectoryURL.appendingPathComponent(imageName)
            
            //            if !FileManager.default.fileExists(atPath: fileURL.path) {
            if (try? UIImageJPEGRepresentation(pickedImage, 1.0)!.write(to: URL(fileURLWithPath: fileURL.path), options: [.atomic])) != nil {
                print("file saved")
                self.profilePicButton.setImage(pickedImage, for: .normal)
            } else {
                print("error saving file")
            }
            
            print(documentsDirectoryURL)
            
        }
        print(info)
        self.profilePicAlphaView.isHidden = true
        self.profilePicStackView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.profilePicAlphaView.isHidden = true
        self.profilePicStackView.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Picker View Delegate And Data Source
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.pickerDataArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.selectedPickerIndex = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        let nameDict = self.pickerDataArray.object(at: row) as! NSMutableDictionary
        let name = nameDict.value(forKey: "Data") as? String
        return name
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
