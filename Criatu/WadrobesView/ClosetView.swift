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
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<style.suggestions.count, id: \.self) { index in
                        Image(uiImage: style.suggestions[index].image)
                            .resizable()
                            .frame(width: 150, height: 200)
                            .cornerRadius(20)
                    }
                }
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
