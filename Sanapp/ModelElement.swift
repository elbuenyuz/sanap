//
//  ModelElement.swift
//  Sanapp
//
//  Created by Daniel Ramirez on 4/27/17.
//  Copyright © 2017 Devius. All rights reserved.
//

import Foundation

class ModelElement {
    
    private var _imageUrl:UIImage!
    private var _name :String!
    private var _description:String!
    
    var imageUrl:UIImage{
        if _imageUrl == nil{
            _imageUrl = #imageLiteral(resourceName: "button00")
        }
        return _imageUrl
    }
    var name:String{
        if _name == nil{
            _name = "por asignar"
        }
        return _name
    }
    var description:String{
        if _description == nil{
            _description = "por asignar"
        }
        return _description
    }
    
    init(name:String,desc:String,path:UIImage) {
        self._name = name
        self._description = desc
        self._imageUrl = path
    }
    init() {
        
    }
}
