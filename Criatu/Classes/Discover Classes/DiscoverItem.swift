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
    var type: ItemType
    
    @Published var url: String?
    
    @Published var isSelected: Bool = false
    
    init(id: String, type: ItemType) {
        self.id = id
        self.type = type
    }
}
