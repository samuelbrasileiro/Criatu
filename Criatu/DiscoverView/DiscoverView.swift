//
//  DiscoverView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

struct DiscoverView: View {
    
    @ObservedObject var bank: DiscoverBank
    @State var index = 0
    
    var body: some View {
                
        VStack{
            
            SearchBarView(bank: bank)
            if bank.isSearching {
                
                List {
                    // Filtered list of ALL INTERESTS FROM FIREBASE
                    ForEach((0..<bank.interests.count).filter{ bank.interests[$0].name.hasPrefix(bank.searchText) || bank.searchText == ""}, id:\.self) { index in
                        Button(action:{
                            UIApplication.shared.endEditing(true) // this must be placed before the other commands here
                            self.bank.searchText = ""
                            self.bank.isSearching = false
                        }){
                        Text(bank.interests[index].name)
                        }
                    }
                }
                .resignKeyboardOnDragGesture()
            }
            else{
                
                ScrollView(.horizontal, showsIndicators: false){
                    LazyHStack{//list of USER'S INTERESTS
                        ForEach(0..<bank.interests.count, id: \.self){ index in
                            InterestView(item: bank.interests[index])
                        }
                    }.frame(height: 50)
                    .padding(.leading)
                }
                LazyWaterfallGrid(data: bank.items, numberOfColumns: 2, horizontalSpacing: 8, verticalSpacing: 8, edgeInsets: EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)){ item in
                    
                    BasicItemView(item: item)
                    
                }.background(Color(.systemGray6))
            }
        }
        
    }
}


struct DiscoverView_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverView(bank: DiscoverBank())
    }
}
