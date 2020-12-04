//
//  InterestView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

struct InterestView: View {
    @ObservedObject var item: Interest
    
    @State var foregroundColor: Color = Color(.systemGray)
    @State var backgroundColor: Color = Color(.systemGray5)
    
    @ObservedObject var palette = Palette.shared
    
    var delegate: DiscoverDelegate?
    
    var body: some View{
        Button(action: {
            item.isSelected = !item.isSelected
            if item.isSelected{
                delegate?.didSelectInterest(item)
            }
            else{
                delegate?.didDisselectInterest(item)
            }
            changeColors()
        }){
           
            Text(item.attributes.name)
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
        }
        .onAppear(){
            changeColors()
        }
    }
    
    func changeColors(){
        if item.isSelected{
            foregroundColor = Color(.systemBackground)
            backgroundColor = palette.main
        }
        else{
            foregroundColor = Color(.systemGray)
            backgroundColor = Color(.systemGray5)
        }
    }
}

struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView(item: DiscoverBank().interests[0])
    }
}
