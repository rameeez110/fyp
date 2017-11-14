//
//  SignupTeacherViewController.swift
//  fyp
//
//  Created by Rameez Hasan on 10/14/17.
//  Copyright © 2017 AnyCart. All rights reserved.
//

import UIKit

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
        
//        self.profilePicButton.layer.cornerRadius = self.profilePicButton.
//        self.profilePicButton.clipsToBounds = true
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
