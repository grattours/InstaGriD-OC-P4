//
//  ViewController.swift
//  InstaGriD-OC-P4
//
//  Created by Luc Derosne on 13/01/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ui_Chevron: UILabel!
    
    @IBOutlet weak var ui_Button1: UIButton!
    @IBOutlet weak var ui_Button2: UIButton!
    @IBOutlet weak var ui_Button3: UIButton!
    
    @IBOutlet weak var ui_LayersView1: UIStackView!
    @IBOutlet weak var ui_LayersView2: UIStackView!
    @IBOutlet weak var ui_LayersView3: UIStackView!
    
    
    @IBOutlet weak var layer2ImageView1: UIImageView!
    
    var imagePicker:  UIImagePickerController?
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        ui_LayersView1.isHidden = true
        ui_LayersView2.isHidden = true
        ui_LayersView3.isHidden = true
        ui_Button1.imageView?.isHidden = true
        ui_Button2.imageView?.isHidden = true
        ui_Button3.imageView?.isHidden = true
        
        switch sender.tag {
        case 1:
            print("bouton gauche 1 22")
            ui_LayersView1.isHidden = false
            ui_Button1.imageView?.isHidden = false
           // ui_Button1.setImage(UIImage(named: "Selected"), for: .normal)
        case 2:
            print("bouton centre 11 2")
            ui_LayersView2.isHidden = false
            ui_Button2.imageView?.isHidden = false
           ui_Button2.setImage(UIImage(named: "Selected"), for: .normal)
        case 3:
            print("bouton droit 11 22")
            ui_LayersView3.isHidden = false
            ui_Button3.imageView?.isHidden = false
            //ui_Button3.setImage(UIImage(named: "Selected"), for: .normal)
        default:
            print("impossible")
        }
        // sender.tag
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_LayersView1.isHidden = true
        ui_LayersView2.isHidden = false
        ui_LayersView3.isHidden = true
        ui_Button1.imageView?.isHidden = true
        ui_Button2.imageView?.isHidden = false
        ui_Button3.imageView?.isHidden = true
        
        layer2ImageView1.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(searchPhoto))
        layer2ImageView1.addGestureRecognizer(tap)
        imagePicker = UIImagePickerController()
        imagePicker?.delegate = self
        imagePicker?.allowsEditing = true
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.ui_Chevron.text = "<"
            } else {
                self.ui_Chevron.text = "⌃"
            }
        })
    }
    
    // recherche photo avec le tap... selector  dans le viewDidload
    @objc func searchPhoto() {
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

    // après le choix de l'image - remplacement dans l'UIImageView
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        print("après choix")
        let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)
        var photo: UIImage?
        if let edited = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.editedImage)] as? UIImage {
            photo = edited
            
        } else if let original = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            photo = original
        }
        layer2ImageView1.image = photo
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
