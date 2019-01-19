//
//  ViewController.swift
//  InstaGriD-OC-P4
//
//  Created by Luc Derosne on 13/01/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // label et chevron dans un Stack
    @IBOutlet weak var ui_Chevron: UILabel!
    @IBOutlet weak var ui_LabeSwipToShare: UILabel!
    @IBOutlet weak var ui_StackSwip: UIStackView!
    
    @IBOutlet weak var ui_Button1: UIButton!
    @IBOutlet weak var ui_Button2: UIButton!
    @IBOutlet weak var ui_Button3: UIButton!
    
    // calques de photos
    @IBOutlet weak var ui_LayersView1: UIStackView!
    @IBOutlet weak var ui_LayersView2: UIStackView!
    @IBOutlet weak var ui_LayersView3: UIStackView!
    
    // tableaux de photos par calques
    @IBOutlet var tabLayersView1: [UIImageView]!
    @IBOutlet var tabLayersView2: [UIImageView]!
    @IBOutlet var tabLayersView3: [UIImageView]!
    
    var imagePicker:  UIImagePickerController?
    var alternateImage: UIImage? //image à placer
    var tagOfTap: Int = 0  // tag du bouton tapé
    var currentLayerView:  UIStackView! // pour le partage
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        hiddeAll()
        // on refait apparaître le calque et la coche du bouton choisi
        hideShowForDisposition(sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_Button2.setImage(UIImage(named: "Selected"), for: .normal)
        // on peut partager avant de cliquer un bouton
        currentLayerView = ui_LayersView2
        // interagir avec les images des calques
        interactWithAllPhotosOfLayer(tabLayersView2)
        swipToShare()
    }
    // on inverse le chevron et on change le label paysage/portrait
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                self.ui_Chevron.text = "<"
                self.ui_LabeSwipToShare.text = "Swipe left to share"
            } else {
                self.ui_Chevron.text = "⌃"
                self.ui_LabeSwipToShare.text = "Swipe up to share"
            }
        })
    }
    
    // chaque diposition cache ou pas son contenu au clic bouton
    func hideShowForDisposition(_ disposition: Int){
        hiddeAll() // on réinitialise en cachant tout
        // on affiche que ce que la dispo permet
        switch disposition {
        case 1:
            ui_LayersView1.isHidden = false
            ui_Button1.imageView?.isHidden = false
            ui_Button1.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView1)
            currentLayerView = ui_LayersView1
        case 2:
            ui_LayersView2.isHidden = false
            ui_Button2.imageView?.isHidden = false
            ui_Button2.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView2)
            currentLayerView = ui_LayersView2
        case 3:
            ui_LayersView3.isHidden = false
            ui_Button3.imageView?.isHidden = false
            ui_Button3.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView3)
            currentLayerView = ui_LayersView3
        default:
            print("impossible")
        }
    }
// cache toutes les coches "Selected" et les calques
    func hiddeAll() {
        ui_LayersView1.isHidden = true
        ui_LayersView2.isHidden = true
        ui_LayersView3.isHidden = true
        ui_Button1.setImage(UIImage(named: ""), for: .normal)
        ui_Button2.setImage(UIImage(named: ""), for: .normal)
        ui_Button3.setImage(UIImage(named: ""), for: .normal)
        ui_Button1.imageView?.isHidden = true
        ui_Button2.imageView?.isHidden = true
        ui_Button3.imageView?.isHidden = true
    }
    
    // extrait du ViewDidload - autorise geste up et left
    fileprivate func swipToShare() {
        // gérer le swip - left pour paysage up pour portrait
        let left = UISwipeGestureRecognizer(target : self, action : #selector(ViewController.leftSwipe))
        left.direction = .left
        self.ui_StackSwip.addGestureRecognizer(left)
        let up = UISwipeGestureRecognizer(target : self, action : #selector(ViewController.upSwipe))
        up.direction = .up
        self.ui_StackSwip.addGestureRecognizer(up)
    }
    
    // action sur le geste en fonction du sens
    @objc
    func leftSwipe(){
        let imageView = UIImageView(image: currentLayerView.image)
        let contentToshare: UIImage = imageView.image!
        let activity = UIActivityViewController(activityItems: [contentToshare], applicationActivities: nil )
        present(activity,animated: true, completion: nil)
    }
    
    @objc
    func upSwipe(){
        let imageView = UIImageView(image: currentLayerView.image)
        let contentToshare: UIImage = imageView.image!
        let activity = UIActivityViewController(activityItems: [contentToshare], applicationActivities: nil )
        present(activity,animated: true, completion: nil)
    }
    
} // fin classe
