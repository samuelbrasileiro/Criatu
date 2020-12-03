//
//  ClosetView.swift
//  Criatu
//
//  Created by Beatrix Lee on 30/11/20.
//

import SwiftUI

struct ClosetView: View {
    
    @ObservedObject var style: Style
    
    var body: some View {
        
        VStack(alignment: .leading) {
            
            Text("Sugestões para looks")
                .padding([.top, .leading])
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<(style.suggestions.count < 5 ? style.suggestions.count : 5), id: \.self) { index in
                        
                        NavigationLink(destination: SaveLooksView(style: style,  suggestionIndex: index)) {
                            
                            Image(uiImage: style.suggestions[index].image)
                                .resizable()
                                .frame(idealWidth: 150, minHeight: 120)
                                .cornerRadius(20)
                        }
                    }
                }
                .padding([.top, .leading])
                
            }
            
            
            
            ScrollView{
                LazyVStack(alignment: .leading, spacing: 30){
                    ForEach(0..<style.drawers.count, id: \.self){index in
                        Button(style.drawers[index].name ?? ""){
                            print("eita")
                        }
                        
                    }
                    Spacer()
                }
                
            }.frame(height: 400)
            
            
        }
        .navigationTitle(style.attributes.name)
        .onAppear {
            if style.suggestions.isEmpty {
                style.getSuggestions()
            }
        }
    }
}


struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView(style: ClosetsBank().styles[0])
    }
}
