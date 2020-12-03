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
                                .scaledToFill()
                                .frame(width: 100, height: 200)
                                .clipped()
                                
                                .cornerRadius(20)
                            
                        }
                    }
                }
                .padding([.top, .leading])
                
            }
            
            VStack(alignment: .leading){
                Text("Gavetas")
                    .font(.largeTitle)
                    .padding()
                ScrollView{
                    LazyVStack(alignment: .leading, spacing: 10){
                        ForEach(0..<style.drawers.count, id: \.self){index in
                            Button(action: {
                                
                            }){
                                HStack{
                                    Text(style.drawers[index].name ?? "")
                                        .padding()
                                    Spacer()
                                }
                                
                                .background(Color(.systemPurple))
                                .foregroundColor(Color(.systemGray6))
                                .cornerRadius(10)
                                .padding(.horizontal)
                            }
                            
                        }
                        
                    }
                    
                }
            }
            .background(Color(.systemGray6))
            .cornerRadius(20, corners: [.topLeft, .topRight])
            
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
