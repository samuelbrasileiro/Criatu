//
//  ImageItem.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

class ImageItem: DiscoverItem {
    var image: UIImage?
    var imageID: Int
    var tagsArray:[String]
    
    init(imageID: Int, tagsArray: [String],image: UIImage?) {
        self.imageID = imageID
        self.tagsArray = tagsArray
        self.image = image
        super.init(id: "", url: "", type: .image)
    }
}
