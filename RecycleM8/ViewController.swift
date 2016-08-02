//
//  ViewController.swift
//  RecycleM8
//
//  Created by Alexander Kyei on 4/9/16.
//  Copyright © 2016 Alexander Kyei. All rights reserved.
//

import UIKit
import MobileCoreServices



class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, CACameraSessionDelegate{
    
    @IBOutlet var cameraView: CameraSessionView!
    
   

    @IBOutlet weak var cancelCam: UIButton!
    @IBOutlet weak var Camera: UIButton!
    
    @IBAction func cancelCam(sender: UIButton) {
        cameraView = CameraSessionView.init(frame: self.view.frame)
        cameraView.delegate = self
        cameraView.hideDismissButton()
        self.view.addSubview(cameraView)
    }
    
    @IBOutlet weak var ImageDisplay: UIImageView!
    
    @IBOutlet weak var SendButton: UIButton!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let cameraView = CameraSessionView.init(frame: self.view.frame)
        cameraView.delegate = self;
        cameraView.hideDismissButton()
        self.view.addSubview(cameraView)
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 /*   @IBAction func PhotoLibraryAction(sender: UIButton) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
        
    } */
    
    @objc func didCaptureImage(image: UIImage){
        self.view.addSubview(ImageDisplay);
        self.view.addSubview(SendButton)
        ImageDisplay.image = image
    
        
    }

    /*@objc func didCaptureImageWithData(imageData : NSData) -> (void) {
        
    } */
    
    /*@IBAction func CameraAction(sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    } */
    
    /*func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        ImageDisplay.image = info[UIImagePickerControllerOriginalImage] as? UIImage; dismissViewControllerAnimated(true, completion: nil)
        
    } */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if SendButton === sender {
            let request = segue.destinationViewController as! DetermineItemController
           // let request = nvc.viewControllers.first as! DetermineItemController
            request.image = ImageDisplay.image
            
        }
    }
    
}

