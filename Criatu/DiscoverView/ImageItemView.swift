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
    @State var foregroundColor: Color = Palette.shared.main
    @State var backgroundColor: Color = Color(.systemGray5)
    
    @ObservedObject var palette = Palette.shared
    @State private var progress = 0.5
    
    var delegate: DiscoverDelegate?
    
    var body: some View {
        
        Button( action: {
            item.isSelected = !item.isSelected
            changeColors()
            delegate?.uploadView()
            
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
            delegate?.uploadView()
        }
    }
    
    func changeColors(){
        if item.isSelected{
            stroke = palette.main
            foregroundColor = Color(.systemGray5)
            backgroundColor = palette.main
        }
        else{
            stroke = .clear
            foregroundColor = palette.main
            backgroundColor = Color(.systemGray5)
        }
    }
}

//struct ImageItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageItemView(item: ImageItem(id: "1500952424", url: "1500952424", type: .image))
//    }
//}


