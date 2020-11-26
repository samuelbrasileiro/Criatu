//
//  DiscoverBank.swift
//  Criatu
//
//  Created by Beatrix Lee on 18/11/20.
//

import UIKit
import SwiftUI
import AVKit

protocol DiscoverDelegate{
    func didSelectInterest(_ interest: Interest)
    func didDisselectInterest(_ interest: Interest)
}

class DiscoverBank: ObservableObject, Identifiable, DiscoverDelegate {
    
    @Published var items: [DiscoverItem] = []
    
    @Published var interests: [Interest] = []
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    @Published var allInterests: [Interest] = []
    

    init() {
        self.clear()
        
        self.addItems()
        
    }
    
    /// This function clears all items in the array 'items'
    
    func clear(){
        items.removeAll()
        interests.removeAll()
    }
    
    func addInterests(){
        
        if var interests = Interest.restore(){
            interests.shuffle()
            print(interests.count)
            let count = interests.count < 3 ? interests.count : 3
            for index in 0..<count{
                interests[index].isSelected = true
                self.didSelectInterest(interests[index])
            }
            self.interests = interests

        }
    }
    func getItem(from id: String){
        FirebaseHandler.readCollection(.items, id: id, dataType: DiscoverItem.Database.self){ result in
            if case .success(let attribute) = result{
                if attribute.type == .image{
                    self.items.append(ImageItem(attributes: attribute))
                }
                else if attribute.type == .music{
                    self.items.append(MusicItem(attributes: attribute))
                }
            }
        }
    }
    func getAllInterests(){
        self.allInterests = []
        FirebaseHandler.readAllCollection(.interests, dataType: [Interest.Database].self){ result in
            if case .success(let attributes) = result{
                for attribute in attributes{
                    let interest = Interest(attributes: attribute)
                    self.allInterests.append(interest)
                }
                self.objectWillChange.send()
            }
        }
    }
    
    func clearAllInterests(){
        self.allInterests.removeAll()
    }
    
    func addInterestToTop(interest: Interest){
        if self.interests.filter({ $0.attributes.id == interest.attributes.id
        }).count == 0{
            self.interests.insert(interest, at: 0)
        }
    }
    
    func didSelectInterest(_ interest: Interest){
        print("Selected Interest: " + interest.attributes.name)
        if var ids = interest.attributes.itemsIDs{
            
            ids.shuffle()
            ids = [String](ids.prefix(4))
            for id in ids{
                if items.map({$0.attributes.id}).contains(id){
                    continue
                }
                FirebaseHandler.readCollection(.items, id: id, dataType: DiscoverItem.Database.self){ result in
                    if case .success(let attributes) = result{
                        
                        if attributes.type == .image{
                            let item = ImageItem(attributes: attributes)
                            item.interestAssociatedID = interest.attributes.id
                            self.items.append(item)
                        }
                        else if attributes.type == .music{
                            let item = MusicItem(attributes: attributes)
                            item.interestAssociatedID = interest.attributes.id
                            self.items.append(item)
                        }
                    }
                }
                
                
            }
            
        }
    }
    func didDisselectInterest(_ interest: Interest){
        items = items.filter{ item in
            return !(item.interestAssociatedID == interest.attributes.id)
        }

    }
    
    /// This function adds all items in the array 'items'
    func addItems(){
        let ids = ["-MMuZ1PpDQGOXWzAdjN4", "-MMuWsbBuTkOGLIrBjX-", "-MMuWy3bg3vMXvU4WnL-", "-MMuZRYLUaAn_RBJcdj8", "-MMuZf-rEs2la53EAZMX"]
        var interests: [Interest] = []
        var count = 0
        for id in ids{
            
            FirebaseHandler.readCollection(.interests, id: id, dataType: Interest.Database.self){ result in
                
                if case .success(let attributes) = result{
                    print("fetch", attributes.name)
                    interests.append(Interest(attributes: attributes))
                    count += 1
                    if count == ids.count{
                        Interest.archive(interests: interests)
                        self.addInterests()
                    }
                }
                
            }
        }
        
        
        print("Archived Interests (Luis to do)")
        
    }
    
}
