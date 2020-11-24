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
        var itemsIDs: [String]?
        private enum CodingKeys : String, CodingKey {
            case id
            case itemsIDs  = "items_ids"
            case name
        }
        init(id: String, name: String, itemsIDs: [String]?){
            self.id = id
            self.name = name
            self.itemsIDs = itemsIDs
        }
    }
    
    
    class func archive(interests: [Interest]){
        let defaults = UserDefaults(suiteName: "group.ufpe.academy.criatu")!
        
        let interests = interests.map{ interest in
            return interest.attributes
        }
        do{
            let interestsData = try JSONEncoder().encode(interests)
            defaults.setValue(interestsData, forKey: Keys.kSelectedInterests)
        }catch{
            print(error)
        }
    }
    class func restore()->[Interest]?{
        let defaults = UserDefaults(suiteName: "group.ufpe.academy.criatu")!
        guard let interestsData = defaults.data(forKey: Keys.kSelectedInterests) else{
            print("could not fetch interests from UserDefaults")
            return nil
        }
        do{
            let interestsAttributes = try JSONDecoder().decode([Interest.Database].self, from: interestsData)
            
            let interests = interestsAttributes.map{ attributes in
                return Interest(attributes: attributes)
            }
            
            return interests
        } catch{
            print(error)
            return nil
        }
        
    }
}



