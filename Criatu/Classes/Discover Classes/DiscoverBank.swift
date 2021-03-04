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
    
    static let shared = DiscoverBank()
    
    @Published var items: [DiscoverItem] = []
    @Published var interests: [Interest] = []
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var allInterests: [Interest] = []
    @Published var discoveredStyle: Style?
    @Published var didDiscoverNewStyle: Bool = false
    @Published var didNotDiscoverStyle: Bool = false
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
            interests.shuffle()
            let count = interests.count < 3 ? interests.count : 3
            for index in 0..<count{
                interests[index].isSelected = true
                self.didSelectInterest(interests[index])
            }
            self.interests = interests

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
        self.isDiscovering = true
        let selectedItems = items.filter{ $0.isSelected }
        var userSet: [String] = []
        var similarityResults: [String : Float] = [:]
        
        let closets: [ClosetInterface] = [
            ClosetInterface(id: "-MNOV-lGoNFf7Oa7WW1n", tags: ["pizza", "pug", "mulher"]),
            ClosetInterface(id: "-MNP6eErV2Or6qZsipfO", tags: ["paris", "fantasia", "compondo"]),
            ClosetInterface(id: "-MNYbEkkQHkxRK0YMVJo", tags: ["gato", "pedra", "alta", "cavalo"]),
            ClosetInterface(id: "-MNYbNl7yyEmDZ9hdZPK", tags: ["frutas", "halteres", "fitness"]),
            ClosetInterface(id: "-MNYbT6ljnhwJcLHv2Xn", tags: ["frança", "cor", "frança", "égua"]),
        ]
        
        for item in selectedItems {
            userSet.append(contentsOf: item.tagsArray.map{ $0 })
        }
        
        for closet in closets {
            similarityResults[closet.id] = SetSimilarity.jaccardSimilarity(firstSet: userSet, secondSet: closet.tags)
        }
        
        let sortedDictionary = similarityResults.sorted {
            (first: (key: String, value: Float), second: (key: String, value: Float)) -> Bool in
            return first.value > second.value
        }
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false){ _ in
            self.isDiscovering = false
            
            
            FirebaseHandler.readCollection(.closets, id: sortedDictionary[0].key, dataType: Style.Database.self) { result in
                if case .success(let attributes) = result {
                    self.discoveredStyle = Style(attributes: attributes)
                    self.didDiscoverNewStyle = true
                } else {
                    self.didNotDiscoverStyle = true
                }
            }
            
        }
    }
    
    func clearAllInterests(){
        self.allInterests.removeAll()
    }
    
    func addInterestToTop(interest: Interest){
        if self.interests.filter({ $0.attributes.id == interest.attributes.id}).count == 0{
            self.interests.insert(interest, at: 0)
        }
    }
    
    func didSelectInterest(_ interest: Interest){
        
        let api = PixabayAPI()
        api.getData(tagsSearched: interest.attributes.name, completionHandler: {_ in
            print("Did select Interest")
        })
        
        if var ids = interest.attributes.itemsIDs{
            
            ids.shuffle()
            ids = [String](ids.prefix(4))
            for id in ids{
                FirebaseHandler.readCollection(.items, id: id, dataType: DiscoverItem.Database.self){ result in
                    if case .success(let attributes) = result{
                        if self.items.map({$0.attributes.id}).contains(id){
                            return
                        }
                        if attributes.type == .music{
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
        //Old itens filter
        items = items.filter{ item in
            return !(item.interestAssociatedID == interest.attributes.id)
        }
        
        //New PixaBay itens filter
        items = items.filter { item in
            return !item.tagsArray.contains(interest.attributes.name.lowercased())
        }

    }
    
    func uploadView() {
        self.objectWillChange.send()
    }
    
    func getItem(from id: String){
        FirebaseHandler.readCollection(.items, id: id, dataType: DiscoverItem.Database.self){ result in
            if case .success(let attribute) = result{
                if attribute.type == .music{
                    self.items.append(MusicItem(attributes: attribute))
                }
            }
        }
    }
    
}
