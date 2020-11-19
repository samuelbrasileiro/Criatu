//
//  ImageItem.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 19/11/20.
//

import SwiftUI

///The view containing the settings of the images that will appear in the feed

struct ImageItemView: View {
    
    @ObservedObject var imageItem: ImageItem
    
    @State var isSelected: Bool = false
    
    @State var stroke: Color = Color.clear
    @State var foregroundColor: Color = Color(.systemPurple)
    @State var backgroundColor: Color = Color(.systemGray5)
    
    var body: some View {
        
        Button( action: {
            isSelected = !isSelected
            if isSelected{
                stroke = Color(.systemPurple)
                foregroundColor = Color(.systemGray5)
                backgroundColor = Color(.systemPurple)
            }
            else{
                stroke = .clear
                foregroundColor = Color(.systemPurple)
                backgroundColor = Color(.systemGray5)
            }
            
        }){
            
            (imageItem.image == nil ? Image(systemName: "person.circle.fill") : Image(uiImage: imageItem.image!))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(stroke, lineWidth: 5))
                .cornerRadius(10)
        }
    }
}

struct ImageItemView_Previews: PreviewProvider {
    static var previews: some View {
        ImageItemView(imageItem: ImageItem(id: "1500952424", type: .image))
    }
}


