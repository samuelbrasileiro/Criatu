//
//  ClosetView.swift
//  Criatu
//
//  Created by Beatrix Lee on 30/11/20.
//

import SwiftUI

struct ClosetView: View {
    
    @ObservedObject var style: Style
    
    @ObservedObject var palette = Palette.shared
    
    @State var newDrawerName: String = ""
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Sugestões para looks")
                .padding([.top, .leading])
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<(style.suggestions.count < 5 ? style.suggestions.count : 5), id: \.self) { index in
                        
                        NavigationLink(destination: SaveLooksView(style: style,  suggestionIndex: index)) {
                            
                            Image(uiImage: style.suggestions[index].image)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 100, height: 160)
                                .clipped()
                                
                                .cornerRadius(20)
                            
                        }
                    }
                }
                .padding(.leading)
                
            }
            .frame(height: 180)
            
            Text("Gavetas")
                .font(.largeTitle)
                .bold()
                .padding()
            ScrollView{
                LazyVStack(spacing: 20){
                    ForEach(0..<style.drawers.count, id: \.self){index in
                        NavigationLink(destination: DrawerView(drawer: style.drawers[index])){
                            HStack{
                                Text(style.drawers[index].name ?? "")
                                    .bold()
                                    
                                    .padding()
                                Spacer()
                            }
                            
                            .background(Color(.systemGray4))
                            .foregroundColor(palette.main)
                            
                            .cornerRadius(15)
                            .padding(.horizontal)
                        }
                        
                    }
                    
                    TextField("Crie uma nova gaveta", text: $newDrawerName, onCommit: {
                        if !newDrawerName.isEmpty{
                            style.createDrawer(name: newDrawerName)
                            newDrawerName = ""
                        }
                    })
                    .padding()
                    .background(Color(.systemGray5))
                    .foregroundColor(palette.main)
                    .cornerRadius(15)
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .strokeBorder(
                                style: StrokeStyle(
                                    lineWidth: 2,
                                    dash: [15]
                                )
                            )
                            .foregroundColor(palette.main)
                    )
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .padding(.vertical)
                .padding(.bottom)
                
                
            }
            
            .background(Color(.systemGray6))
            .cornerRadius(20)
            
        }
        .resingKeyboardOnTapGesture()
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
