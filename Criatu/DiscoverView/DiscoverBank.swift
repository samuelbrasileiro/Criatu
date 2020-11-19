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

class DiscoverItem: ObservableObject {
    var id: String
    @Published var url: String?
    var type: ItemType
    
    init(id: String, type: ItemType) {
        self.id = id
        self.type = type
    }
}

class MusicItem: DiscoverItem {
    @Published var title: String?
    @Published var artistName: String?
    
    @Published var imageAlbumURL: String?
    @Published var imageAlbum: UIImage?
    
    override init(id: String, type: ItemType) {
        super.init(id: id, type: type)
    }
}

class ImageItem: DiscoverItem, ObservableObject {
    @Published   var image: UIImage?
    
    override init(id: String, type: ItemType) {
        super.init(id: id, type: type)
    }
    
    func getImage(){
        let request = URLRequest(url: URL(string: url!)!)
        URLRequest.shared.dataTask(with: request) {(data, response, error) in
            DispacheQueue.main.async {
                guard let data = data else{
                    return
                }
                if let image = UIImage(data: data){
                    self.image = image
                }
            }
        } .resume()
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
