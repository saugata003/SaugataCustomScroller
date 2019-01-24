//
//  UIScrollView+Additions.swift
//  CustomScroller
//
//  Created by Saugata Chakraborty on 21/01/19.
//  Copyright © 2019 OPTLPTP183. All rights reserved.
//

import UIKit
let iPhoneInitialButtonWidth = 90
let iPhoneInitialButtonHeight = 30
let iPhonePadding = 10
let buttonFontSize:CGFloat = 14
let buttonFont = "HelveticaNeue"
let buttonPadding = 20
let initialOrigin = 0
let iPhoneConstant = 10
let iPhoneButtonHeight = 50
var mainOptionArray = [String]()
extension UIScrollView {
    func setScrollViewDesign(buttonTitles:[String], buttonColor:UIColor, titleColor:UIColor) {
        
        var xOrigin = initialOrigin
        var yOrigin = initialOrigin
        var buttonWidth = initialOrigin
        var padding = initialOrigin
        var screenMaxWidth = initialOrigin
        
        for item in self.subviews {
            if item is UIButton {
                item.removeFromSuperview()
            }
        }
        
        buttonWidth = iPhoneInitialButtonWidth
        padding = iPhonePadding
        screenMaxWidth = Int(UIScreen.main.bounds.size.width) - buttonPadding

        for i in 0..<buttonTitles.count {
            let tempbutton = UIButton()
            if i == initialOrigin {
                xOrigin = padding
                yOrigin = padding
            } else {
                if xOrigin + buttonWidth + padding > screenMaxWidth {
                    xOrigin = padding
                    yOrigin = yOrigin + iPhoneInitialButtonHeight + padding
                } else {
                    xOrigin = xOrigin + buttonWidth + padding
                }
            }
            buttonWidth = Int(self.customButtonWidth(textString: buttonTitles[i] as String))
            if xOrigin != padding && xOrigin + buttonWidth > screenMaxWidth {
                xOrigin = padding
                yOrigin = iPhoneInitialButtonHeight + padding + yOrigin
            }
            
            if buttonWidth > screenMaxWidth {
                buttonWidth = screenMaxWidth
            }
            tempbutton.titleLabel?.font = UIFont.init(name: buttonFont, size: buttonFontSize)
            tempbutton.setTitle(buttonTitles[i], for: .normal)
            tempbutton.frame = CGRect(x: xOrigin, y: yOrigin, width: buttonWidth, height: iPhoneInitialButtonHeight)
            tempbutton.tag = i
            tempbutton.setImage(UIImage(named: ""), for: .normal)
            tempbutton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
            tempbutton.backgroundColor = buttonColor
            tempbutton.setTitleColor(titleColor, for: .normal)
            tempbutton.layer.cornerRadius = CGFloat(iPhoneInitialButtonHeight/2)
            tempbutton.clipsToBounds = true
            tempbutton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            self.addSubview(tempbutton)
        }
        self.contentSize = CGSize(width: self.frame.width, height: (self.subviews.last?.frame.origin.y)! + (self.subviews.last?.frame.size.height)! + 20)
    }
    
    func customButtonWidth(textString:String) -> CGFloat {
        
        if let font = UIFont(name: buttonFont, size: buttonFontSize) {
            let fontAttributes = [NSAttributedStringKey.font: font]
            let size = (textString as NSString).size(withAttributes: fontAttributes)
            return size.width + CGFloat(buttonPadding*2)
        }
        return 0.0
    }
    
    @objc func buttonPressed(sender:UIButton) {
        for i in 0..<mainOptionArray.count {
            if sender.tag == i {
                if sender.image(for: .normal) == UIImage(named: "") {
                    sender.setImage(UIImage(named: "Check_Filter"), for: .normal)
                    sender.backgroundColor = UIColor.init(hexString: "#c8c8c8")
                } else {
                    sender.setImage(UIImage(named: ""), for: .normal)
                    sender.backgroundColor = UIColor.init(hexString: "#ebebeb")
                }
            }
        }
    }
}
