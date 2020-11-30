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
                LazyHStack {
                    ForEach(0..<style.suggestions.count, id: \.self) { index in
                        Image(uiImage: style.suggestions[index].image)
                            .resizable()
                            .frame(width: 150, height: 200)
                            .cornerRadius(20)
                    }
                }
            }
        }
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
