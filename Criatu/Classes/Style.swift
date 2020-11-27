//
//  Style.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation
import UIKit

class Style: ObservableObject{
    
    var attributes: Style.Database
    
    @Published var image: UIImage?
    
    init(id: String, name: String, description: String, imageURL: String){
        attributes = Style.Database(id: id, name: name, description: description, imageURL: imageURL)
        
        getImage()
    }
    
    init(attributes: Style.Database){
        self.attributes = attributes
        getImage()
    }
    
    /// From image URL this function downloads and saves the
    /// image data in 'image' attribute
    func getImage(){
        let request = URLRequest(url: URL(string: attributes.imageURL)!)
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else{
                    return
                }
                if let image = UIImage(data: data){
                    self.image = image
                }
            }
        } .resume()
    }
    
    class Database: Codable{
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
