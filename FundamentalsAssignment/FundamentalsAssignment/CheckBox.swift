//
//  CheckBox.swift
//  FundamentalsAssignment
//
//  Created by egmars.janis.timma on 07/05/2019.
//  Copyright © 2019 egmars.janis.timma. All rights reserved.
//

import UIKit

//@IBDesignable

protocol UIButtonDelegate: AnyObject {
    func checkButtons()
}
class CheckBox: UIButton {
    
//    func scaleImageToSize(img: UIImage, size: CGSize) -> UIImage {
//        UIGraphicsBeginImageContext(size)
//        img.draw(in: CGRect(origin: CGPointZero, size: size))
//        if let scaledImage = UIGraphicsGetImageFromCurrentImageContext() {
//        UIGraphicsEndImageContext()
//        return scaledImage
//        }
//    }

//    var vc = ViewController()
    let checkedImage = UIImage(named: "checked_checkbox")
    let unCheckedImage = UIImage(named: "unchecked_checkbox")
    
    weak var delegate : UIButtonDelegate?
//    @IBInspectable
    var isChecked: Bool = false {
        didSet {
            self.updateImage()
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(CheckBox.buttonClicked), for: UIControl.Event.touchUpInside)
        self.updateImage()
    }
    
    func updateImage() {
        if isChecked == true {
            self.setImage(checkedImage, for: [])
        } else {
            self.setImage(unCheckedImage, for: [])
        }
    }
    
    @objc func buttonClicked(sender: UIButton) {
        if(sender == self) {
            isChecked = !isChecked
            delegate?.checkButtons()
//            ViewController().searchByBody.append()
            print("clicked button tag: \(sender.tag),  \(sender.titleLabel?.text)")

        }
    }
}
