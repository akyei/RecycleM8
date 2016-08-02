//
//  DefaultController.swift
//  RecycleM8
//
//  Created by Alexander Kyei on 4/9/16.
//  Copyright © 2016 Alexander Kyei. All rights reserved.
//

import Foundation
import UIKit

class DefaultController : UIViewController {
    
    let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("cameraView")
    
    
    @IBOutlet weak var startButton: UIButton!
    
   /* @IBAction func pressStart(sender: UIButton) {
        
        performSegueWithIdentifier("cameraView", sender: self)
        //self.presentViewController(viewController, animated: false, completion: nil)
    } */
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}
