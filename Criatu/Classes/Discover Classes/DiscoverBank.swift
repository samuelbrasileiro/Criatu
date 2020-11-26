//
//  DiscoverBank.swift
//  Criatu
//
//  Created by Beatrix Lee on 18/11/20.
//

import UIKit
import SwiftUI
import AVKit

class DiscoverBank: ObservableObject, Identifiable {
    
    @Published var items: [DiscoverItem] = []
    
    @Published var interests: [Interest] = []
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    @Published var allInterests: [Interest] = []
    

    init() {
        self.clear()
        
        self.addInterests()
        self.addItems()
        
    }
    
    /// This function clears all items in the array 'items'
    
    func clear(){
        items.removeAll()
        interests.removeAll()
    }
    
    func addInterests(){
        if let interests = Interest.restore(){
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
    
    func clearAllInterests(){
        self.allInterests.removeAll()
    }
    
    func addInterestToTop(interest: Interest){
        if self.interests.filter({ $0.attributes.id == interest.attributes.id
        }).count == 0{
            self.interests.insert(interest, at: 0)
        }
    }
    /// This function adds all items in the array 'items'
    func addItems(){
        items.append(MusicItem(id: "1500952424", type: .music))
        items.append(ImageItem(id: "900032829", type: .image))
        items.append(ImageItem(id: "1500952424", type: .image))
        items.append(ImageItem(id: "900032829", type: .image))
        items.append(MusicItem(id: "1500952424", type: .music))
        items.append(MusicItem(id: "900032829", type: .music))
        items.append(MusicItem(id: "900032829", type: .music))
        items.append(ImageItem(id: "1500952424", type: .image))
        items.append(MusicItem(id: "1500952424", type: .music))
        items.append(ImageItem(id: "900032829", type: .image))
        items.append(ImageItem(id: "1500952424", type: .image))
        items.append(ImageItem(id: "900032829", type: .image))
        items.append(MusicItem(id: "1500952424", type: .music))
        items.append(MusicItem(id: "900032829", type: .music))
        items.append(MusicItem(id: "900032829", type: .music))
        items.append(ImageItem(id: "1500952424", type: .image))
    }
    
}
