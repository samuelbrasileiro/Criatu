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
    
    init(imageID: Int, tagsArray: [String],image: UIImage?) {
        self.imageID = imageID
        self.image = image
        super.init(id: "", url: "", type: .image)
        self.tagsArray = tagsArray
    }
}
