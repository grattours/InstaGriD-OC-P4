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
    @IBOutlet weak var ui_LabeSwipToShare: UILabel!
    
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
    // photos du calque 2
    @IBOutlet  var layer2ImageView1: UIImageView!
    @IBOutlet  var layer2ImageView2: UIImageView!
    @IBOutlet  var layer2ImageView3: UIImageView!
    
    // redéfinition des calques en tableau d'imageView
    
    var imagePicker:  UIImagePickerController?
    var alternateImage: UIImage?
    var tagOfTap: Int = 0
    
    @IBAction func buttonSelected(_ sender: UIButton) {
//        ui_LayersView1.isHidden = true
//        ui_LayersView2.isHidden = true
//        ui_LayersView3.isHidden = true
//        ui_Button1.imageView?.isHidden = true
//        ui_Button2.imageView?.isHidden = true
//        ui_Button3.imageView?.isHidden = true
        hiddeAll()
       // son refait apparaître le calque et la coche du bouton
        switch sender.tag {
        case 1:
            print("bouton gauche 1 22")
            ui_LayersView1.isHidden = false
            ui_Button1.imageView?.isHidden = false
            ui_Button1.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView1)
        case 2:
            print("bouton centre 11 2")
            ui_LayersView2.isHidden = false
            ui_Button2.imageView?.isHidden = false
            ui_Button2.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView2)
        case 3:
            print("bouton droit 11 22")
            ui_LayersView3.isHidden = false
            ui_Button3.imageView?.isHidden = false
            ui_Button3.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView3)
        default:
            print("impossible")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // faire une fonction setup
        ui_LayersView1.isHidden = true
        ui_LayersView2.isHidden = false
        ui_LayersView3.isHidden = true
        ui_Button1.imageView?.isHidden = true
        ui_Button2.imageView?.isHidden = false
        ui_Button2.setImage(UIImage(named: "Selected"), for: .normal)
        ui_Button3.imageView?.isHidden = true
        // interagir avec les images des calques
//        interactWihPhotosLayer(layer2ImageView1)
         interactWithAllPhotosOfLayer(tabLayersView2)
//        interactWihPhotosLayer(layer2ImageView2)
//        interactWihPhotosLayer(layer2ImageView3)

    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { context in
            if UIApplication.shared.statusBarOrientation.isLandscape {
                print("landscape")
                //self.hiddeAll()
                self.ui_Chevron.text = "<"
                self.ui_LabeSwipToShare.text = "Swipe left to share"
                // Bouton tag 1 2 3
                print("tagOfTap = \(self.tagOfTap)")
                //self.hideShowForDisposition(2)
            } else {
                print("portrait")
                print("tagOfTap = \(self.tagOfTap)")
                //self.hiddeAll()
                self.ui_Chevron.text = "⌃"
                self.ui_LabeSwipToShare.text = "Swipe up to share"
                //self.hideShowForDisposition(2)
            }
        })
    }
 
    
    /// à virer juste pour controle de séquence
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print(" init")
    }
    
    override func loadView() {
        super.loadView()
        print(" loadView")
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        print("A : viewDidLoad")
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(" viewWillAppear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(" viewDidAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(" viewWillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(" viewDidDisappear")
    }
    
    func hideShowForDisposition(_ disposition: Int){
        hiddeAll()
        switch disposition {
        case 1:
            print("bouton gauche 1 22")
            ui_LayersView1.isHidden = false
            ui_Button1.imageView?.isHidden = false
            ui_Button1.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView1)
        case 2:
            print("bouton centre 11 2")
            ui_LayersView2.isHidden = false
            ui_Button2.imageView?.isHidden = false
            ui_Button2.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView2)
        case 3:
            print("bouton droit 11 22")
            ui_LayersView3.isHidden = false
            ui_Button3.imageView?.isHidden = false
            ui_Button3.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView3)
        default:
            print("impossible")
        }
    }
    
    func hiddeAll() {
        print("hiddeAll")
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
}
