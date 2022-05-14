//  UIViewExtension.swift
//  DwitBook

import Foundation
import UIKit

extension UIView {
    
    func setShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowOpacity = 0.15
        self.layer.shadowRadius = 4
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
    }
    
    func setBorder() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.borderColor = UIColor.lightGray.withAlphaComponent(0.4).cgColor
        self.layer.borderWidth = 1
    }
    
    func addBottomBorder(color: UIColor?, lineWidth: CGFloat) {
        let bottomLayer = CALayer()
        bottomLayer.frame = CGRect(x: 0, y: self.frame.height, width: self.frame.width, height: lineWidth)
        bottomLayer.backgroundColor = color?.cgColor
        
        self.layer.addSublayer(bottomLayer)
    }
    
    func addBlurEffect() {
        let blurEffect = UIBlurEffect(style: .regular)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
    }
}
