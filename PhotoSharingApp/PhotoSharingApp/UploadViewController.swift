//
//  UploadViewController.swift
//  PhotoSharingApp
//
//  Created by Caner Çağrı on 1.04.2022.
//

import UIKit
import Firebase

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var commentTextField: UITextField!
    @IBOutlet var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(pickImage))
        imageView.addGestureRecognizer(gesture)
    }
    
    @IBAction func uploadBtnTapped(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()
        
        let mediaFolder = storageReference.child("media")
        
        let uuid = UUID().uuidString
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5 ) {
            
            let imageReference = mediaFolder.child("\(uuid).jpg")
            
            imageReference.putData(data, metadata: nil) { storageMetaData, error in
                if error != nil {
                    self.showError(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error! Try Again")
                } else {
                    imageReference.downloadURL { url, error in
                        if error == nil {
                            if let imageUrl = url?.absoluteString {
                                let fireStoreDatabase = Firestore.firestore()
                                
                                let fireStorePost = ["email" : Auth.auth().currentUser!.email! , "imageurl" : imageUrl, "comment" : self.commentTextField.text! , "date" : FieldValue.serverTimestamp()] as [String : Any]
                                
                                fireStoreDatabase.collection("Post").addDocument(data: fireStorePost) { error in
                                    if error != nil {
                                        self.showError(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error! Try Again")
                                    } else {
                                        self.imageView.image = UIImage(named: "addimage")
                                        self.commentTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0 
                                    }
                                }
                            }
                           
                        }
                    }
                }
            }
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true)
    }
    
    @objc func pickImage() {
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true)
    }
    
    func showError (titleInput : String , messageInput : String) {
        let ac = UIAlertController(title: titleInput, message: messageInput, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(ac, animated: true)
    }


}
