//
//  LauncherStyleUImageView.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 4/26/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import UIKit

class LauncherStyleUImageView: UIImageView {
    
    
    
    
    override func awakeFromNib() {
        
        layer.cornerRadius = 15.0
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        layer.borderWidth = 1.0
        layer.borderColor = UIColor.white.cgColor
        
    }
    
}
