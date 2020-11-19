//
//  DiscoverBank.swift
//  Criatu
//
//  Created by Beatrix Lee on 18/11/20.
//

import UIKit
import SwiftUI

class DiscoverBank: ObservableObject, Identifiable {
    
    @Published var items: [DiscoverItem] = []
    
    @Published var interests: [Interest] = []
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    init() {
        self.clear()
        
        self.addInterests()
        self.addItems()
        
    }
    
    /// This function clears all items in the array 'items'
    
    func clear(){
        items = []
        interests = []
    }
    
    func addInterests(){
        interests.append(Interest(id: "", name: "Woodstock"))
        interests.append(Interest(id: "", name: "Sertanejo"))
        interests.append(Interest(id: "", name: "Gatos"))
        interests.append(Interest(id: "", name: "Ar Livre"))
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
