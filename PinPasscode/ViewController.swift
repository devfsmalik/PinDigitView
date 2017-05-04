//
//  ViewController.swift
//  PinPasscode
//
//  Created by Qaiser Shehzad on 5/3/17.
//  Copyright © 2017 Qaiser Shehzad. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate,PinCustomViewDelegate {
    
    @IBOutlet weak var pinView: UIView!
    
    let customPinView = PinCustomView.getPinCustomView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        pinView.addSubview(customPinView)
        
        customPinView.delegate = self
       // customPinView.setColors(normal: UIColor.blue, highlightedColor: UIColor.yellow)
        
    }
    
    override func viewWillLayoutSubviews() {
        customPinView.frame = pinView.bounds
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func didFinishTask(finalPin:String) {
        // do stuff like updating the UI or some api call for verification
        
        print(">>>>>>>>>>>>>> Pin entered"+finalPin)
    }
    
}

