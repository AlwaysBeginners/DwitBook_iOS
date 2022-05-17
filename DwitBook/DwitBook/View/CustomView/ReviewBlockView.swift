//  ReviewBlockView.swift
//  DwitBook

import UIKit

class ReviewBlockView: UIView {
    
    var shadowLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setBorder(color: .lightGray.withAlphaComponent(0.4), width: 1, radius: 10)
        self.clipsToBounds = false
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setBorder(color: .lightGray.withAlphaComponent(0.4), width: 1, radius: 10)
        self.clipsToBounds = false
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 10).cgPath
        shadowLayer.fillColor = self.backgroundColor?.cgColor

        shadowLayer.shadowOpacity = 0.1
        shadowLayer.shadowRadius = 4
        shadowLayer.shadowOffset = CGSize(width: 0, height: 3)

        self.layer.insertSublayer(shadowLayer, at: 0)
    }
}
