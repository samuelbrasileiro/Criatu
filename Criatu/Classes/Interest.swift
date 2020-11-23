//
//  Interest.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation


class Interest: ObservableObject {
    var id: String
    var name: String
    
    @Published var isSelected: Bool = false
    
    init(id: String, name: String){
        self.id = id
        self.name = name
    }
    
    ///Returning a dictionary to classes
    var dictionary: [String:Any] {
        return ["id": id,
                "name": name]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
    
    
}
