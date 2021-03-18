//
//  SearchBarView.swift
//  Criatu
//
//  Created by Beatrix Lee on 18/11/20.
//

import SwiftUI

/// The search bar view

struct SearchBarView: View {
    
    @ObservedObject var bank: DiscoverBank
    
    @ObservedObject var palette = Palette.shared
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Como está sua vibe?", text: $bank.searchText, onEditingChanged: {
                    isEditing in
                    
                    self.bank.isSearching = true
                    
                    
                }, onCommit:{
                    
                    let api = PixabayAPI()
                    api.getData(tagsSearched: bank.searchText, completionHandler: {_ in
                        api.downloadImages()
                    })
                    let interest = Interest(id: "", name: self.bank.searchText, itemsIDs: [])
                    interest.isSelected = true
                    bank.interests.insert(interest, at: 0)
                    var interests = Interest.restore()
                    interests?.insert(interest, at: 0)
                    Interest.archive(interests: interests ?? [])
                    self.bank.searchText = ""
                }).foregroundColor(.primary)
                
                Button(action: {
                    self.bank.searchText = ""
                }) {
                    Image(systemName: "xmark.circle.fill").opacity(bank.searchText == "" ? 0 : 1)
                }
            }
            .padding(EdgeInsets(top: 8, leading: 6, bottom: 8, trailing: 6))
            .foregroundColor(.secondary)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10.0)
            
            if bank.isSearching {
                Button("Cancelar") {
                    UIApplication.shared.endEditing(true)
                    self.bank.searchText = ""
                    self.bank.isSearching = false
                    self.bank.clearAllInterests()
                }
                .foregroundColor(palette.main)
            }
        }
        .padding(.horizontal)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBarView(bank: DiscoverBank.shared)
    }
}
