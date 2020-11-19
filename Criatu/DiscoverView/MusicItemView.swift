//
//  MusicItemView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

struct MusicItemView: View{
    
    @ObservedObject var item: MusicItem
        
    @State var stroke: Color = Color.clear
    @State var foregroundColor: Color = Color(.systemPurple)
    @State var backgroundColor: Color = Color(.systemGray5)
    
    var body: some View{
        if let name = item.title{
            Button(action: {
                item.isSelected = !item.isSelected
                changeColors()
                
            }){
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text(name)
                            .bold()
                            .lineLimit(2)
                            
                        Text(item.artistName!)
                            .font(.footnote)
                            .lineLimit(2)
                            
                    }
                    Spacer()
                    Button(action: {
                        
                        
                        
                    }){
                        Image(systemName: "play.fill")
                    }
                        
                }
                .padding()
                .frame(minHeight: 0, maxHeight: 100, alignment: .center)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
                
            }.onAppear(){
                changeColors()
            }
        }
    }
    
    func changeColors(){
        if item.isSelected{
            stroke = Color(.systemPurple)
            foregroundColor = Color(.systemGray5)
            backgroundColor = Color(.systemPurple)
        }
        else{
            stroke = .clear
            foregroundColor = Color(.systemPurple)
            backgroundColor = Color(.systemGray5)
        }
    }
}

struct MusicItemView_Previews: PreviewProvider {
    static var previews: some View {
        MusicItemView(item: MusicItem(id: "1500952424", type: .music))
    }
}
