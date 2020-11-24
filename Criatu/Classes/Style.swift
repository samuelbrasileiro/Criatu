//
//  Style.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation
import UIKit

class Style: ObservableObject{
    
    var attributes: Style.FDatabase
    
    @Published var image: UIImage?
    
    init(id: String, name: String, description: String, imageURL: String){
        attributes = FDatabase(id: id, name: name, description: description, imageURL: imageURL)
    }
    
    init(attributes: FDatabase){
        self.attributes = attributes
    }
    
    class FDatabase: Codable{
        var id: String
        var name: String
        var description: String
        var imageURL: String
        
        init(id: String, name: String, description: String, imageURL: String){
            self.id = id
            self.name = name
            self.description = description
            self.imageURL = imageURL
        }
        
    }
}
