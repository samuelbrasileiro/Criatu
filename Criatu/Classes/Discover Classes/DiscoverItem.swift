//
//  Item.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import SwiftUI

enum ItemType: String, Codable {
    case music
    case image
}

///The basic structure for a discover item that will be displayed
class DiscoverItem: ObservableObject {
    var attributes: DiscoverItem.Database
    
    @Published var isSelected: Bool = false
    
    @Published var url: String?
    
    init(id: String, type: ItemType){
        self.attributes = DiscoverItem.Database(id: id, type: type, stylesID: [])
    }
    
    init(attributes: DiscoverItem.Database){
        self.attributes = attributes
    }
    
    class Database: Codable{
        var id: String
        var type: ItemType
        var stylesIDs: [String]
        init(id: String, type: ItemType, stylesID: [String]){
            self.id = id
            self.type = type
            self.stylesIDs = stylesID
        }
    }
}
