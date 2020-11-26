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
    
    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                TextField("Search", text: $bank.searchText, onEditingChanged: {
                    isEditing in
                    if !self.bank.isSearching{
                        self.bank.getAllInterests()
                    }
                    self.bank.isSearching = true
                    
                    
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
                Button("Cancel") {
                    UIApplication.shared.endEditing(true)
                    self.bank.searchText = ""
                    self.bank.isSearching = false
                    self.bank.clearAllInterests()
                }
                .foregroundColor(Color(.systemBlue))
            }
        }
        .padding(.horizontal)
    }
}

struct SearchBarView_Previews: PreviewProvider {
    
    static var previews: some View {
        SearchBarView(bank: DiscoverBank())
    }
}
