//
//  Look.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//


import Foundation
import UIKit

class LookItem: ObservableObject{
    var attributes: LookItem.FDatabase
    var image: UIImage?
    

    
    init(id: String, imageURL: String){
        self.attributes = FDatabase(id: id, imageURL: imageURL)
    }
    
    init(attributes: FDatabase){
        self.attributes = attributes
    }
    
    class FDatabase: Codable{
        var id: String
        var imageURL: String

        init(id: String, imageURL: String){
            self.id = id
            self.imageURL = imageURL
        }
    }
    
}
