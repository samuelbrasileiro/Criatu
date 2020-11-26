//
//  ImageItem.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 19/11/20.
//

import SwiftUI

///The view containing the settings of the images that will appear in the feed

struct ImageItemView: View {
    
    @ObservedObject var item: ImageItem
        
    @State var stroke: Color = Color.clear
    @State var foregroundColor: Color = Color(.systemPurple)
    @State var backgroundColor: Color = Color(.systemGray5)
    
    @State private var progress = 0.5
    
    var body: some View {
        
        Button( action: {
            item.isSelected = !item.isSelected
            changeColors()
            
        }){
            if let image = item.image{
                Image(uiImage: image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(stroke, lineWidth: 5))
                .cornerRadius(10)
            }
            else{
                Rectangle()
                    .foregroundColor(Color(.systemGray4))
                    .frame(height: 100)
                    .overlay(ProgressView(value: progress)
                                .progressViewStyle(CircularProgressViewStyle()))
                    .cornerRadius(10)
            }
        }
        .onAppear(){
            changeColors()
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

struct ImageItemView_Previews: PreviewProvider {
    static var previews: some View {
        ImageItemView(item: ImageItem(id: "1500952424", url: "1500952424", type: .image))
    }
}


