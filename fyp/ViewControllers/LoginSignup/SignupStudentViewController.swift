//
//  SignupStudentViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/14/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

class SignupStudentViewController: UIViewController , UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate , UIPickerViewDelegate , UIPickerViewDataSource{
    
    @IBOutlet weak var profilePicAlphaView: UIView!
    
    @IBOutlet weak var profilePicStackView: UIStackView!
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var epNumTextField: UITextField!
    @IBOutlet weak var enrollmentNumTextField: UITextField!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var profilePicButton: UIButton!
    @IBOutlet weak var degreeProgramButton: UIButton!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var sectionButton: UIButton!
    @IBOutlet weak var morningEveningButton: UIButton!
    
    // UIPicker Flow
    @IBOutlet weak var pickerDoneButton: UIButton!
    @IBOutlet weak var descriptionPickerView: UIPickerView!
    var pickerData: [String] = [String]()
    
    //Image Picekr
    var imagePicker = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // MARK: - View UI
    
    func setupUI()
    {
        self.createButton.layer.cornerRadius = 10
        self.createButton.clipsToBounds = true
        
//        self.signupButton.layer.cornerRadius = 15
//        self.signupButton.clipsToBounds = true
        
        self.degreeProgramButton.layer.cornerRadius = 10
        self.degreeProgramButton.clipsToBounds = true
        
        self.yearButton.layer.cornerRadius = 10
        self.yearButton.clipsToBounds = true
        
        self.sectionButton.layer.cornerRadius = 10
        self.sectionButton.clipsToBounds = true
        
        self.morningEveningButton.layer.cornerRadius = 10
        self.morningEveningButton.clipsToBounds = true
    }
    
    // MARK: - IBActions
    
    @IBAction func backButtonPressed()
    {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func createButtonPressed()
    {
        //callApiTocreate
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
        pickerData = ["BSCS", "BSSE"]
        self.profilePicAlphaView.isHidden = false
        self.descriptionPickerView.isHidden = false
        self.pickerDoneButton.isHidden = false
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func yearButtonPressed()
    {
        pickerData = ["First", "Second", "Third","Fourth"]
        self.profilePicAlphaView.isHidden = false
        self.descriptionPickerView.isHidden = false
        self.pickerDoneButton.isHidden = false
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func sectionButtonPressed()
    {
       pickerData = ["A", "B"]
        self.profilePicAlphaView.isHidden = false
        self.descriptionPickerView.isHidden = false
        self.pickerDoneButton.isHidden = false
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func morningEveningButtonPressed()
    {
        pickerData = ["Morning", "Evening"]
        self.profilePicAlphaView.isHidden = false
        self.descriptionPickerView.isHidden = false
        self.pickerDoneButton.isHidden = false
        self.descriptionPickerView.reloadAllComponents()
    }
    
    @IBAction func pickerDoneButtonPressed()
    {
        self.profilePicAlphaView.isHidden = true
        self.descriptionPickerView.isHidden = true
        self.pickerDoneButton.isHidden = true
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
        
        //        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        //        {
        //            self.imagePickerCollectionView.isHidden = false
        //            imagePickerMutableArray.add(pickedImage)
        //            self.imagePickerCollectionView.reloadData()
        //        }
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
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
//        selectedIndexForDescription = row
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return pickerData[row]
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
