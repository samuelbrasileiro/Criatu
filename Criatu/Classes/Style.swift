//
//  Style.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation
import UIKit

class Style{
    var id: String
    var name: String
    var description: String
    var imageURL: String
    var image: UIImage?
    
    init(id: String, name: String, description: String, imageURL: String){
        self.id = id
        self.name = name
        self.description = description
        self.imageURL = imageURL
    }
    
    var dictionary: [String:Any] {
        return ["id": id,
                "name": name,
                "description": description,
                "imageURL": imageURL]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
    
}
