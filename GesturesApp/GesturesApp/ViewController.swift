//
//  ViewController.swift
//  GesturesApp
//
//  Created by DCS on 10/12/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private let myView:UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.frame = CGRect(x: 100 , y: 100 , width: 200, height:200)
        return view
    }()
    private let imagePicker:UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        return imagePicker
    }()
    private let myimg:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
       
        
        imageView.clipsToBounds = true
        //imageView.image = UIImage(named: "1")
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(myView)
        myView.addSubview(myimg)
        imagePicker.delegate = self
        myimg.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
         tapGesture.numberOfTapsRequired = 1
         tapGesture.numberOfTouchesRequired = 1
         myView.addGestureRecognizer(tapGesture)
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: #selector(didRotateView))
        view.addGestureRecognizer(rotationGesture)
        
        
        let pinchGesture  = UIPinchGestureRecognizer(target: self, action: #selector(didPinchView))
        view.addGestureRecognizer(pinchGesture)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        rightSwipe.direction = .right
        view.addGestureRecognizer(rightSwipe)
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        upSwipe.direction = .up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(didSwipeView))
        downSwipe.direction = .down
        view.addGestureRecognizer(downSwipe)
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(didPanView))
        view.addGestureRecognizer(panGesture)
    }
    
    
    @objc private func didTapView(gesture : UITapGestureRecognizer) {
        print("Tapped at Location : \(gesture.location(in: myView))")
        print("gallery called")
        imagePicker.sourceType = .photoLibrary
        DispatchQueue.main.async {
            self.present(self.imagePicker, animated: true)
            
            
        

    }
     
        
       
        
}
}
extension ViewController{
    @objc private func didRotateView(gesture:UIRotationGestureRecognizer){
        myimg.transform = CGAffineTransform(rotationAngle: gesture.rotation)
    }
    
    @objc private func didPinchView(gesture : UIPinchGestureRecognizer) {
        myimg.transform = CGAffineTransform(scaleX: gesture.scale, y: gesture.scale)
    }
    @objc private func didSwipeView(gesture : UISwipeGestureRecognizer){
        if gesture.direction == .left{
            
            myimg.frame = CGRect(x: myimg.frame.origin.x-40 , y: myimg.frame.origin.y, width:200 , height:200)
        }else if gesture.direction == .right{
            myimg.frame = CGRect(x: myimg.frame.origin.x+40 , y: myimg.frame.origin.y, width:200 , height:200)
            
        }else if gesture.direction == .up{
            myimg.frame = CGRect(x: myimg.frame.origin.x , y: myimg.frame.origin.y - 40, width:200 , height:200)
        }else if gesture.direction == .down{
            myimg.frame = CGRect(x: myimg.frame.origin.x , y: myimg.frame.origin.y + 40, width:200 , height:200)
            
        }
    }
    @objc private func didPanView(gesture: UIPanGestureRecognizer){
        let x = gesture.location(in: view).x
        let y = gesture.location(in: view).y
        
        myimg.center = CGPoint(x: x, y: y)
    }
}
    
    extension ViewController:UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let selectedImage = info[.originalImage] as? UIImage {
               
                myimg.image = selectedImage
            }
            picker.dismiss(animated: true)
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        
}

