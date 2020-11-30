//
//  Style.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation
import UIKit

class Style: ObservableObject, Identifiable{
    
    var attributes: Style.Database
    
    @Published var image: UIImage?
    
    @Published var suggestions: [Look] = []
    
    @Published var drawers: [Drawer] = []
    
    init(id: String, name: String, description: String, imageURL: String){
        attributes = Style.Database(id: id, name: name, description: description, imageURL: imageURL, looksURL: [])
        
        getImage()
    }
    
    init(attributes: Style.Database){
        self.attributes = attributes
        getImage()
    }
    
    struct Look {
        var image: UIImage
        var url: String
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
    
    func getSuggestions() {
        
        if let looks = attributes.looksURL {
            for look in [String](looks.shuffled().prefix(4)) {
                
                let request = URLRequest(url: URL(string: look)!)
                URLSession.shared.dataTask(with: request) {(data, response, error) in
                    DispatchQueue.main.async {
                        
                        guard let data = data else{
                            return
                        }
                        
                        if let image = UIImage(data: data) {
                            self.suggestions.append(Look(image: image, url: look))
                        }
                    }
                } .resume()
            }
        }
    }
        
        class Database: Codable{
            var id: String
            var name: String
            var description: String
            var imageURL: String
            var looksURL: [String]?
            
            init(id: String, name: String, description: String, imageURL: String, looksURL: [String]?){
                self.id = id
                self.name = name
                self.description = description
                self.imageURL = imageURL
                self.looksURL = looksURL
            }
            
        }
    }
