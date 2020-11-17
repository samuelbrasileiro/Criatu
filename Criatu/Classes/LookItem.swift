//
//  Look.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//


import Foundation
import UIKit

class LookItem{
    var id: String
    var imageURL: String
    var image: UIImage?
    
    init(id: String, imageURL: String){
        self.id = id
        self.imageURL = imageURL
    }
}