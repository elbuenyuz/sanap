//
//  StyleImgView.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 5/2/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class StyleImgView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func awakeFromNib() {
        
        layer.cornerRadius = 5.0
        layer.shadowColor = UIColor(red:SHADOW_COLOR, green: SHADOW_COLOR, blue: SHADOW_COLOR, alpha: 0.5).cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        
    }
}
