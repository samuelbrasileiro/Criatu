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
    
    var interestAssociatedID: String?
    
    init(id: String, url: String, type: ItemType){
        self.attributes = DiscoverItem.Database(id: id, url: url, type: type, stylesID: [])
    }
    
    init(attributes: DiscoverItem.Database){
        self.attributes = attributes
    }
    
    class Database: Codable{
        var id: String
        var url: String
        var type: ItemType
        var stylesIDs: [String]?
        private enum CodingKeys : String, CodingKey {
            case id, url, type
            case stylesIDs  = "styles_ids"
            
        }
        init(id: String, url: String, type: ItemType, stylesID: [String]?){
            self.id = id
            self.url = url
            self.type = type
            self.stylesIDs = stylesID
        }
    }
}
