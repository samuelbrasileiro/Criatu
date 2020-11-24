//
//  Look.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//


import Foundation
import UIKit

class LookItem: ObservableObject{
    var attributes: LookItem.Database
    var image: UIImage?
    

    
    init(id: String, imageURL: String){
        self.attributes = LookItem.Database(id: id, imageURL: imageURL)
    }
    
    init(attributes: LookItem.Database){
        self.attributes = attributes
    }
    
    class Database: Codable{
        var id: String
        var imageURL: String

        init(id: String, imageURL: String){
            self.id = id
            self.imageURL = imageURL
        }
    }
    
}
