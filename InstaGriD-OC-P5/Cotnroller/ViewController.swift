//
//  ViewController.swift
//  InstaGriD-OC-P5
//
//  Created by Luc Derosne on 13/01/2019.
//  Copyright © 2019 Luc Derosne. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    // label and chevron in a stack
    @IBOutlet weak var ui_Chevron: UILabel!
    @IBOutlet weak var ui_LabeSwipToShare: UILabel!
    @IBOutlet weak var ui_StackSwip: UIStackView!
    
    @IBOutlet weak var ui_Button1: UIButton!
    @IBOutlet weak var ui_Button2: UIButton!
    @IBOutlet weak var ui_Button3: UIButton!
    @IBOutlet weak var ui_Button4: UIButton!
    
    // layers of photos
    @IBOutlet weak var ui_LayersView1: UIStackView!
    @IBOutlet weak var ui_LayersView2: UIStackView!
    @IBOutlet weak var ui_LayersView3: UIStackView!
    @IBOutlet weak var ui_LayersView4: UIStackView!
    
    // photo tables by layers
    @IBOutlet var tabLayersView1: [UIImageView]!
    @IBOutlet var tabLayersView2: [UIImageView]!
    @IBOutlet var tabLayersView3: [UIImageView]!
    @IBOutlet var tabLayersView4: [UIImageView]!
    
    var imagePicker:  UIImagePickerController?
    var alternateImage: UIImage? //image to place
    var tagOfTap: Int = 0  // button tag typed
    var currentLayerView:  UIStackView! // for sharing
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        hiddeAll()
        // the layer and the tick of the chosen button are redone
        hideShowForDisposition(sender.tag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ui_Button2.setImage(UIImage(named: "Selected"), for: .normal)
        // we can share before clicking a button
        currentLayerView = ui_LayersView2
        // interact with layer images
        interactWithAllPhotosOfLayer(tabLayersView2)
        swipToShare()
    }
    // we reverse the chevron and change the label landscape / portrait
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
    
    // each layout shows its content at the click of a button
    func hideShowForDisposition(_ disposition: Int){
        hiddeAll() // we reset by hiding everything
        // we show that what the dispo allows
        switch disposition {
        case 1:
            useTransition(ui_LayersView1, .transitionFlipFromTop)
            ui_LayersView1.isHidden = false
            ui_Button1.imageView?.isHidden = false
            ui_Button1.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView1)
            currentLayerView = ui_LayersView1
        case 2:
            useTransition(ui_LayersView2, .transitionCurlUp)
            ui_LayersView2.isHidden = false
            ui_Button2.imageView?.isHidden = false
            ui_Button2.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView2)
            currentLayerView = ui_LayersView2
        case 3:
            useTransition(ui_LayersView3, .transitionCrossDissolve)
            ui_LayersView3.isHidden = false
            ui_Button3.imageView?.isHidden = false
            ui_Button3.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView3)
            currentLayerView = ui_LayersView3
        case 4:
            useTransition(ui_LayersView4, .transitionCurlDown)
            ui_LayersView4.isHidden = false
            ui_Button4.imageView?.isHidden = false
            ui_Button4.setImage(UIImage(named: "Selected"), for: .normal)
            interactWithAllPhotosOfLayer(tabLayersView4)
            currentLayerView = ui_LayersView4
        default:
            print("impossible")
        }
        
    }
// hides all selected checkmarks and layers
    func hiddeAll() {
        ui_LayersView1.isHidden = true
        ui_LayersView2.isHidden = true
        ui_LayersView3.isHidden = true
        ui_LayersView4.isHidden = true
        ui_Button1.setImage(UIImage(named: ""), for: .normal)
        ui_Button2.setImage(UIImage(named: ""), for: .normal)
        ui_Button3.setImage(UIImage(named: ""), for: .normal)
        ui_Button4.setImage(UIImage(named: ""), for: .normal)
        ui_Button1.imageView?.isHidden = true
        ui_Button2.imageView?.isHidden = true
        ui_Button3.imageView?.isHidden = true
        ui_Button4.imageView?.isHidden = true
    }
    
    // extract from ViewDidload - allows gesture up and left
    fileprivate func swipToShare() {
        // manage the swip - left for landscape up for portrait
        let left = UISwipeGestureRecognizer(target : self, action : #selector(ViewController.leftSwipe))
        left.direction = .left
        self.ui_StackSwip.addGestureRecognizer(left)
        let up = UISwipeGestureRecognizer(target : self, action : #selector(ViewController.upSwipe))
        up.direction = .up
        self.ui_StackSwip.addGestureRecognizer(up)
    }
    
    // action on the gesture according to the meaning
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
    
    // 1  .transitionFlipFromTop
    // 2  .transitionCurlUp
    // 3  .transitionCurlDown
    // 4  .transitionFlipFromLeft
    // 5  .transitionCrossDissolve
    // 6  .transitionFlipFromRight
    // 7  .transitionFlipFromTop
    fileprivate func useTransition(_ layer: UIStackView, _ transition: UIView.AnimationOptions) {
        UIView.transition(from: layer,
                          to: layer,
                          duration: 0.5,
                          options: [transition, .showHideTransitionViews],
                          completion: nil)
    }
    
} // end class
