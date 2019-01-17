//
//  PhotosViewController.swift
//  InstaGriD-OC-P4
//
//  Created by Luc Derosne on 14/01/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

extension ViewController {
    
    // interagir avec les photos du calque lancé depuis viewdiload
//    func interactWihPhotosLayer(_ ImageView :UIImageView) {
//        print("interact")
//        ImageView.isUserInteractionEnabled = true
//        let tap = UITapGestureRecognizer(target: self, action: #selector(searchPhotoToReplace(tap: )))
//        print("tap UITapGestureRecognizer dans interactWihPhotosLayer" )
//        ImageView.addGestureRecognizer(tap)
//        imagePicker = UIImagePickerController()
//        imagePicker?.delegate = self
//        imagePicker?.allowsEditing = true
//    }
    
    func interactWithAllPhotosOfLayer(_ tabLayersView :[UIImageView] ) {
        print("nb image dans le calque \(tabLayersView.count)")
        let nb = tabLayersView.count
        for i in 0 ..< nb {
            print("i = \(i)")
            tabLayersView[i].isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target: self, action: #selector(searchPhotoToReplace(tap: )))
            print("tap UITapGestureRecognizer dans interactWihPhotosLayer" )
            tabLayersView[i].addGestureRecognizer(tap)
            imagePicker = UIImagePickerController()
            imagePicker?.delegate = self
            imagePicker?.allowsEditing = true
            }
        }
   
    // recherche photo avec le tap... selector  dans le viewDidload
    @objc func searchPhotoToReplace(tap: UITapGestureRecognizer) {
        //guard let tag = tap.view?.tag else { return }
        tagOfTap = tap.view?.tag ?? 0
        print("tap tag dans searchPhotoToReplace")
        //var tag = tap.view?.tag
        //print("récup du tag de l'image: \(String(describing: tag))")
        
        // ImageOfTheTag(tag)
        guard imagePicker != nil else { return }
        let alert = UIAlertController(title: "Choisir une photo", message: "dans la photothéque", preferredStyle: .actionSheet)
        let library = UIAlertAction(title: "photothéque", style: .default) { (act) in self.imagePicker?.sourceType = .photoLibrary
            self.present(self.imagePicker!, animated: true, completion: nil)
        }
        let exit = UIAlertAction(title: "Annuler", style: .cancel, handler: nil)
        
        alert.addAction(library)
        alert.addAction(exit)
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func ImageOfTheTag(_ tag:Int){
//        o    tag: 11 image: tabLayersView1[0]
//        o    tag: 12 image: tabLayersView1[1]
//        o    tag: 13 image: tabLayersView1[2]
//        o    tag: 21 image: tabLayersView2[0]
//        o    tag: 22 image: tabLayersView2[1]
//        o    tag: 23 image: tabLayersView2[2]
//        o    tag: 31 image: tabLayersView3[0]
//        o    tag: 32 image: tabLayersView3[1]
//        o    tag: 33 image: tabLayersView3[2]
//        o    tag: 34 image: tabLayersView3[3]
//    print("ImageOfTheTag")
        //print(tag)
        switch tag {
        case 11:
            tabLayersView1[0].image = alternateImage
            alternateImage = nil
        case 12:
            tabLayersView1[1].image = alternateImage
            alternateImage = nil
        case 13:
            tabLayersView1[2].image = alternateImage
            alternateImage = nil
        case 21:
            tabLayersView2[0].image = alternateImage
            alternateImage = nil
        case 22:
            tabLayersView2[1].image = alternateImage
            alternateImage = nil
        case 23:
            tabLayersView2[2].image = alternateImage
            alternateImage = nil
        case 31:
            tabLayersView3[0].image = alternateImage
            alternateImage = nil
        case 32:
            tabLayersView3[1].image = alternateImage
            alternateImage = nil
        case 33:
            tabLayersView3[2].image = alternateImage
            alternateImage = nil
        case 34:
            tabLayersView3[3].image = alternateImage
            alternateImage = nil
        default:
            print("autre")
        }
   }
    
    // après le choix de l'image - remplacement dans l'UIImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // print("après choix")
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        var photo: UIImage?
        if let edited = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            photo = edited
            
        } else if let original = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            photo = original
        }
        // layer2ImageView1.image = photo
        print("alternatImage dans imagePickerController")
        alternateImage = photo
        ImageOfTheTag(tagOfTap)
        // attributePhotoInImageView(gesture: tapGesture!)
        // let tag = gesture.view?.tag
        imagePicker?.dismiss(animated: true, completion: nil)
    }
    
}

// Helper

fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
    return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
    return input.rawValue
}

