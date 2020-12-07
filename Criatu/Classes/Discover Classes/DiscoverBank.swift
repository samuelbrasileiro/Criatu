//
//  DiscoverBank.swift
//  Criatu
//
//  Created by Beatrix Lee on 18/11/20.
//

import UIKit
import SwiftUI
import CoreData

protocol DiscoverDelegate{
    func didSelectInterest(_ interest: Interest)
    func didDisselectInterest(_ interest: Interest)
    func uploadView()
}


class DiscoverBank: ObservableObject, Identifiable, DiscoverDelegate {
    
    @Published var items: [DiscoverItem] = []
    
    @Published var interests: [Interest] = []
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    @Published var allInterests: [Interest] = []
    
    @Published var discoveredStyle: Style?
    @Published var didDiscoverNewStyle = false
    @Published var didNotDiscoverStyle = false
    
    @Published var isDiscovering: Bool = false
    
    
    init() {
        self.clear()
        
        self.addInterests()
        
    }
    
    /// This function clears all items in the array 'items'
    func clear(){
        items.removeAll()
        interests.removeAll()
        searchText = ""
        isSearching = false
        allInterests.removeAll()
        discoveredStyle = nil
        isDiscovering = false
        didDiscoverNewStyle = false
        didNotDiscoverStyle = false
    }
    
    func addInterests(){
        
        if var interests = Interest.restore(){
            print(interests)
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
    
    func discoverStyle(){
        isDiscovering = true
        items = items.filter{
            $0.isSelected
        }
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false){ _ in
            self.isDiscovering = false
            let context = AppDelegate.viewContext
            
            let stylesIDs = [String](self.items.map({$0.attributes.stylesIDs ?? []}).joined())
            
            let reducedIDs = stylesIDs.reduce([String:Int]()) { dict, id in
                var dict = dict
                
                dict[id] = (dict[id] ?? 0)
                dict[id]! += 1
                
                return dict
            }.map{$0}
            
            let sortedIDs = reducedIDs.sorted{ $0.value > $1.value}
            
            let closetsRequest: NSFetchRequest<Closet> = Closet.fetchRequest()
            
            do {
                let closets = try context.fetch(closetsRequest)
                
                if !sortedIDs.contains(where: { id in id.value >= 4 && !closets.contains(where: {$0.id == id.key})}){
                    self.didNotDiscoverStyle = true
                    print("You already have all suitable closets")
                    return
                }
                print("de boa")
                for id in sortedIDs{
                    print(id.key, "!!! = ", id.value)
                    if !closets.contains(where: {$0.id == id.key}){
                        if id.value >= 4{
                            
                            FirebaseHandler.readCollection(.closets, id: id.key, dataType: Style.Database.self) { result in
                                if case .success(let attributes) = result {
                                                                        
                                    self.discoveredStyle = Style(attributes: attributes)
                                    
                                    self.didDiscoverNewStyle = true
                                    
                                    print(self.discoveredStyle!.attributes.name)

                                }
                            }
                            
                            break
                        }
                    }
                }
                
            }catch{
                print(error)
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

        if var ids = interest.attributes.itemsIDs{
            
            ids.shuffle()
            ids = [String](ids.prefix(4))
            for id in ids{

                FirebaseHandler.readCollection(.items, id: id, dataType: DiscoverItem.Database.self){ result in
                    if case .success(let attributes) = result{
                        if self.items.map({$0.attributes.id}).contains(id){
                            print("we have ", id)
                            return
                        }
                        if attributes.type == .image{
                            let item = ImageItem(attributes: attributes)
                            item.interestAssociatedID = interest.attributes.id
                            self.items.insert(item, at: 0)
                        }
                        else if attributes.type == .music{
                            let item = MusicItem(attributes: attributes)
                            item.interestAssociatedID = interest.attributes.id
                            self.items.insert(item, at: 0)
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
    
    func uploadView() {
        self.objectWillChange.send()
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
