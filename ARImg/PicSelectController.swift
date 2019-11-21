//
//  PicSelectController.swift
//  ARImg
//
//  Created by sxy on 11/21/19.
//  Copyright © 2019 sxy. All rights reserved.
//

import UIKit

class PicSelectController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnChoosePic.layer.cornerRadius = 5
        self.btnGotoAR.layer.cornerRadius = 5
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var imgPreview: UIImageView!
    @IBOutlet weak var btnChoosePic: UIButton!
    
    @IBOutlet weak var btnGotoAR: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    @IBAction func btnGotoAR(_ sender: UIButton) {
    }
    
    @IBAction func btnChoosePic(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender
            alert.popoverPresentationController?.sourceRect = sender.bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            //If you dont want to edit the photo then you can set allowsEditing to false
            imagePicker.allowsEditing = true
            imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
            self.present(imagePicker, animated: true, completion: nil)
        }
        else{
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openGallary(){
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        //If you dont want to edit the photo then you can set allowsEditing to false
        imagePicker.allowsEditing = true
        imagePicker.delegate = self as? UIImagePickerControllerDelegate & UINavigationControllerDelegate
        self.present(imagePicker, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
 extension PicSelectController:
    UIImagePickerControllerDelegate, UINavigationControllerDelegate{
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        /*
//         Get the image from the info dictionary.
//         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
//         instead of `UIImagePickerControllerEditedImage`
//         */
//        guard let editedImage = info[UIImagePickerController.InfoKey.EditedImage] as? UIImage else{
//            print("Error: \(info)")
//        }
//        self.imgPreview.image = editedImage
//        //Dismiss the UIImagePicker after selection
//        picker.dismiss(animated: true, completion: nil)
//    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            // do stuff with your original image...

        } else if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            // do something with your edited image...
            self.imgPreview.image = editedImage
        }
        dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }

}
