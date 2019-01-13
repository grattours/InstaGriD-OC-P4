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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

