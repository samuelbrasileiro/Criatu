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
    
    var body: some View{
        Button(action: {
            item.isSelected = !item.isSelected
            if item.isSelected{
                foregroundColor = Color(.systemBackground)
                backgroundColor = Color(.systemPurple)
            }
            else{
                foregroundColor = Color(.systemGray)
                backgroundColor = Color(.systemGray5)
            }
        }){
           
        Text(item.name)
            .padding()
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .cornerRadius(10)
        }
    }
}

struct InterestView_Previews: PreviewProvider {
    static var previews: some View {
        InterestView(item: DiscoverBank().interests[0])
    }
}
