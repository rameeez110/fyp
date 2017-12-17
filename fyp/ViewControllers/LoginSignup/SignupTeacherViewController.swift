//
//  SignupTeacherViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/14/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit
import Alamofire
import EZLoadingActivity

class SignupTeacherViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    @IBOutlet weak var profilePicAlphaView: UIView!
    
    @IBOutlet weak var profilePicStackView: UIStackView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var qualificationTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var profilePicButton: UIButton!
    
    //Image Picekr
    var imagePicker = UIImagePickerController()
    
    var imageName = String()
    var stringContainingImageData = String()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        setupUI()
    }
    
    // MARK: - View UI
    
    func setupUI()
    {
        self.createButton.layer.cornerRadius = 10
        self.createButton.clipsToBounds = true
        
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
        if self.usernameTextField.text == "" || self.passwordTextField.text == "" || self.emailTextField.text == ""
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
    
    // MARK: - Api Calling
    
    func callApiToRegister()
    {
        let parameters: Parameters = [
            "apiCsrfKey": "FASMBQWIFJDAJ28915734BBKBK8945CTIRETE354PA67",
            "name": self.usernameTextField.text!,
            "password": self.passwordTextField.text!,
            "email": self.emailTextField.text!,
            "profile_pic": self.stringContainingImageData,
            "role_id": "2",
            "meta": self.descriptionTextField.text!,
            "qualification": self.qualificationTextField.text!,
        ]
        performRequestToRegister(parameters: parameters)
    }
    
    func performRequestToRegister(parameters: Parameters)
    {
        Alamofire.request(URLConstants.APPURL.UserRegister, parameters: parameters).responseData { response in
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
                        let teacherID = signupDict.value(forKey: "teacherID") as! Int
                        
                        UserDefaults.standard.set(self.emailTextField.text!, forKey: URLConstants.UserDefaults.LoggedInUserEmail)
                        UserDefaults.standard.set(self.usernameTextField.text!, forKey: URLConstants.UserDefaults.LoggedInTeacherName)
                        UserDefaults.standard.set(self.passwordTextField.text!, forKey: URLConstants.UserDefaults.LoggedInUserPassword)
                        UserDefaults.standard.set(String(userID), forKey: URLConstants.UserDefaults.LoggedInUserId)
                        UserDefaults.standard.set(String(teacherID), forKey: URLConstants.UserDefaults.LoggedInTeacherID)
                        UserDefaults.standard.set("2", forKey: URLConstants.UserDefaults.LoggedInUserRoleId)
                        if self.imageName != ""
                        {
                            UserDefaults.standard.set(self.imageName, forKey: URLConstants.UserDefaults.LoggedInTeacherPicName)
                        }
                        
                        UserDefaults.standard.synchronize()
                        
                        let tabBarController: UITabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TeacherTabBarController") as! UITabBarController
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
