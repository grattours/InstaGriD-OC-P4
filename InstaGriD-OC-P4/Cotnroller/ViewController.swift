//
//  ViewController.swift
//  InstaGriD-OC-P4
//
//  Created by Luc Derosne on 13/01/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var ui_Chevron: UILabel!
    
    @IBOutlet weak var ui_Button1: UIButton!
    @IBOutlet weak var ui_Button2: UIButton!
    @IBOutlet weak var ui_Button3: UIButton!
    
    @IBOutlet weak var ui_LayersView1: UIStackView!
    @IBOutlet weak var ui_LayersView2: UIStackView!
    @IBOutlet weak var ui_LayersView3: UIStackView!
    
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

}

