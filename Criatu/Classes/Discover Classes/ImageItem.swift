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
    
    var imageID:Int
    var tagsArray:[String]
    
    init(imageID: Int, tagsArray: [String],image: UIImage?) {
        self.imageID = imageID
        self.tagsArray = tagsArray
        self.image = image
        super.init(id: "", url: "", type: .image)
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

class ImageItens{
    static var shared:ImageItens = ImageItens()
    var images:[ImageItem] = []
}
