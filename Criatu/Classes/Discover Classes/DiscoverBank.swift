//
//  DiscoverBank.swift
//  Criatu
//
//  Created by Beatrix Lee on 18/11/20.
//

import UIKit
import SwiftUI

///

class DiscoverBank: ObservableObject, Identifiable {
    
    @Published var items: [DiscoverItem] = []
    
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    
    init() {
        self.clear()
        self.addItems()
    }
    
    /// This function clears all items in the array 'items'
    
    func clear(){
        items = []
    }
    
    /// This function adds all items in the array 'items'
    
    func addItems() {
        items.append(MusicItem(id: "", type: .music))
        items.append(ImageItem(id: "", type: .image))
    }
    
}
