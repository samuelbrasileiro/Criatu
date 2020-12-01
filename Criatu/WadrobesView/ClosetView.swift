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
                    ForEach(0..<style.suggestions.count, id: \.self) { index in
                        Image(uiImage: style.suggestions[index].image)
                            .resizable()
                            .frame(idealWidth: 150, minHeight: 120)
                            .cornerRadius(20)
                        
            Text("Gavetas")
                
                        
                    }
                }
                .padding([.top, .leading])
            }
            
            Spacer()
            Rectangle()
                .fill(Color(.systemGray6))
                .frame(height: 400)
                
        }
        .navigationTitle(style.attributes.name)
        .onAppear {
            style.getSuggestions()
        }
    }
}


struct ClosetView_Previews: PreviewProvider {
    static var previews: some View {
        ClosetView(style: ClosetsBank().styles[0])
    }
}
