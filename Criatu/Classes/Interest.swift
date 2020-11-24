//
//  Interest.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation


class Interest: ObservableObject {
    var attributes: Interest.Database
    
    @Published var isSelected: Bool = false
    
    init(id: String, name: String, itemsIDs: [String]){
        self.attributes = Interest.Database(id: id, name: name, itemsIDs: itemsIDs)
    }
    
    init(attributes: Interest.Database){
        self.attributes = attributes
    }
    
    class Database: Codable{
        var id: String
        var name: String
        var itemsIDs: [String]
        
        init(id: String, name: String, itemsIDs: [String]){
            self.id = id
            self.name = name
            self.itemsIDs = itemsIDs
        }
    }
}
    
    

