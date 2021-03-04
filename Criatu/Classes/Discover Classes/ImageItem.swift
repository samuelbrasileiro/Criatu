//
//  ImageItem.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

class ImageItem: DiscoverItem {
    
    @Published var image: UIImage?{
        willSet { self.objectWillChange.send() }
    }
    
    override init(id: String, url: String, type: ItemType) {
        super.init(id: id, url: url, type: type)
                
        getImage()
    }
    
    override init(attributes: DiscoverItem.Database){
        super.init(attributes: attributes)
        
        getImage()
    }
    
    /// From image URL this function downloads and saves the
    /// image data in 'image' attribute
    func getImage(){
        
    
        FirebaseHandler.getItemImage(from: self.attributes.url){ result in
            if case .success(let image) = result{
                self.image = image
            }
        }
        
    }
}
