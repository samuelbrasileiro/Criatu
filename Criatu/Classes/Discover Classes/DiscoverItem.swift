//
//  Item.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import SwiftUI

enum ItemType {
    case music
    case image
}

///The basic structure for a discover item that will be displayed
class DiscoverItem: ObservableObject {
    var id: String
    @Published var url: String?
    var type: ItemType
    
    init(id: String, type: ItemType) {
        self.id = id
        self.type = type
    }
}
