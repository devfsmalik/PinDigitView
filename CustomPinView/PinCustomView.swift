//
//  PinCustomView.swift
//  PinPasscode
//
//  Created by Qaiser Shehzad on 5/4/17.
//  Copyright © 2017 Qaiser Shehzad. All rights reserved.
//

import UIKit

protocol PinCustomViewDelegate: class {
    func didFinishTask(finalPin: String)
}

class PinCustomView: UIView,UITextFieldDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    weak var delegate:PinCustomViewDelegate?

    @IBOutlet weak var oneTF: UITextField!
    @IBOutlet weak var twoTF: UITextField!
    @IBOutlet weak var threeTF: UITextField!
    @IBOutlet weak var fourTF: UITextField!
    @IBOutlet weak var fiveTF: UITextField!
    @IBOutlet weak var sixTF: UITextField!
    @IBOutlet weak var hiddenTF: UITextField!
    
    @IBOutlet weak var oneLine: UIView!
    @IBOutlet weak var twoLine: UIView!
    @IBOutlet weak var threeLine: UIView!
    @IBOutlet weak var fourLine: UIView!
    @IBOutlet weak var fiveLine: UIView!
    @IBOutlet weak var sixLine: UIView!
    
    var pinTFArray = [UITextField]()
    var pinTFBbackgroundArray = [UIView]()  // you can give UIImage
    
    // defaults color
    var digitNormalColor:UIColor? = UIColor.black
    var digitHighlightedColor:UIColor? = UIColor.red
    
    class func getPinCustomView()-> PinCustomView
    {
        
        let nibViews = Bundle.main.loadNibNamed("CustomPinView", owner: self, options: nil)

        return nibViews![0] as! PinCustomView
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        configure();
    }
    
    func setColors(normal:UIColor, highlightedColor:UIColor)  {
        digitNormalColor = normal
        digitHighlightedColor = highlightedColor
        updateTFBgColor()
    }
     func configure() {
        
        hiddenTF.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        
        //# Only Configure arrays with backgrounds and TextFields
        //Add all to array so that we can easily manipulate and traverse all fields. You can add more or can remove TFs as well
        pinTFArray = [oneTF,twoTF,threeTF,fourTF,fiveTF,sixTF]
        pinTFBbackgroundArray = [oneLine,twoLine,threeLine,fourLine,fiveLine,sixLine]
        
        resetTFs()
        
    }
    
    func resetTFs()
    {
        for pinTF in pinTFArray {
            pinTF.text = ""
        }
    }
    func updateTFBgColor()
    {
        for pinTFLine in pinTFBbackgroundArray {
            pinTFLine.backgroundColor = digitNormalColor
        }
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    {
        return true
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool // return NO to disallow editing.
        
    {
        let hiddenText = textField.text!
        
        if hiddenText.characters.count == 0 {
            
            oneLine.backgroundColor = digitHighlightedColor
            
        }
        return true
        
    }
    
    func textFieldDidChange(textField: UITextField) {
        let hiddenText = textField.text!
        
        updateAllTextFieldsForIndex(index:hiddenText.characters.count)
        
        if hiddenText.characters.count == 0 {  // no need to update
            
            return
        }
        if hiddenText.characters.count > pinTFArray.count {
            
            let index = hiddenText.index(hiddenText.startIndex, offsetBy: 6)
            hiddenTF.text =  hiddenText.substring(to: index)  // Hello
            return
        }
        let charAtIndex = hiddenText[hiddenText.index(hiddenText.startIndex, offsetBy:hiddenText.characters.count-1)]
        
        let pinTF = pinTFArray[hiddenText.characters.count-1]
        pinTF.text = String(charAtIndex)
        
        if hiddenText.characters.count == pinTFArray.count {
            
            hiddenTF.resignFirstResponder()
            
            //perform your api call or any other functionality
            
            delegate?.didFinishTask(finalPin: getPinString())

        }
        
    }
    
    func getPinString() -> String {

        var pin:String = ""
        for pinTF in pinTFArray {
            pin += pinTF.text!
        }
        return pin
    }
    func updateAllTextFieldsForIndex(index:Int)
    {
        
        for pinTFBg in pinTFBbackgroundArray {
            pinTFBg.backgroundColor = digitNormalColor
        }
        
        if index < pinTFBbackgroundArray.count  {
            let pinCurrentTFBg = pinTFBbackgroundArray[index]
            pinCurrentTFBg.backgroundColor = digitHighlightedColor
        }
        
        
        // would reset up to all from index
        if index < pinTFArray.count  {
            for i in index ..< pinTFArray.count {
                
                let pinTF = pinTFArray[i]
                pinTF.text = ""
            }
        }
        
    }

}
