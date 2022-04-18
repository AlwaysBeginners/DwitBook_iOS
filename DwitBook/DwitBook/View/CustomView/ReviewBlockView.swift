//
//  ReviewBlockView.swift
//  DwitBook
//
//  Created by 정상윤 on 2022/04/17.
//

import UIKit

class ReviewBlockView: UIView {
    
    var shadowView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(shadowView)
        shadowView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        shadowView.setShadow()
        self.setBorder()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addSubview(shadowView)
        shadowView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
        shadowView.setShadow()
        self.setBorder()
    }

}
