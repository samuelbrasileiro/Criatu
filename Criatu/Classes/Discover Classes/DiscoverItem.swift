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
    var attributes: DiscoverItem.FDatabase
    
    @Published var isSelected: Bool = false
    
    @Published var url: String?
    
    init(id: String, type: ItemType){
        self.attributes = FDatabase(id: id, type: type)
    }
    
    init(attributes: FDatabase){
        self.attributes = attributes
    }
    
    class FDatabase: Codable{
        var id: String
        var type: ItemType
        
        init(id: String, type: ItemType){
            self.id = id
            self.type = type
        }
    }
}
