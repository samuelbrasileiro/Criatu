//
//  DiscoverBank.swift
//  Criatu
//
//  Created by Beatrix Lee on 18/11/20.
//

import UIKit
import SwiftUI

///

enum ItemType {
    case music
    case image
}

class DiscoverItem {
    var id: String
    var url: String?
    var type: ItemType
    
    init(id: String, type: ItemType) {
        self.id = id
        self.type = type
    }
}

class MusicItem: DiscoverItem {
    var title: String?
    var artistName: String?
    
    var imageAlbumURL: String?
    var imageAlbum: UIImage?
    
    override init(id: String, type: ItemType) {
        super.init(id: id, type: type)
    }
}

class ImageItem: DiscoverItem {
    var image: UIImage?
    
    override init(id: String, type: ItemType) {
        super.init(id: id, type: type)
    }
}

class DiscoverBank: ObservableObject, Identifiable {
    
    @Published var items: [DiscoverItem] = []
    
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    
    
    init() {
        self.clear()
        self.addItems()
    }
    
    /// This function clears all items in the array 'items'
    
    func clear(){
        items = []
    }
    
    /// This function adds all items in the array 'items'
    
    func addItems() {
        items.append(MusicItem(id: "", type: .music))
        items.append(ImageItem(id: "", type: .image))
    }
    
}
