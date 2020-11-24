//
//  Interest.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation


class Interest: ObservableObject {
    var attributes: Interest.FDatabase
    
    @Published var isSelected: Bool = false
    
    init(id: String, name: String){
        self.attributes = FDatabase(id: id, name: name)
    }
    
    init(attributes: FDatabase){
        self.attributes = attributes
    }
    
    class FDatabase: Codable{
        var id: String
        var name: String

        init(id: String, name: String){
            self.id = id
            self.name = name
        }
    }
}
    
    

