//
//  ButtonStore.swift
//  Criatu
//
//  Created by Hugo Santos on 01/03/21.
//

import SwiftUI

struct ButtonStore: View {
    @State private var didTap:Bool = false
    @Environment(\.openURL) var openURL

    var body: some View {
        
        Button(action: {
            print("button was tapped")
   
            if didTap == false {
                self.didTap = true
                openURL(URL(string: "https://www.instagram.com/vila.morato/")!)
                       }
            else {
                self.didTap = false
                       }
            
            
        }, label: {
            Text("Visitar Loja")
                .fontWeight(.none)
                .foregroundColor(didTap ? Color.white : Color.purple)
         
                
                .font(.subheadline)
                .padding()
                .padding(-6)
                .background(didTap ? Color.purple : Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.purple, lineWidth: 3)
                       
                      
                )
            
                
        })
      
        
    }
}


struct ButtonStore_Previews: PreviewProvider {
    static var previews: some View {
        ButtonStore()
    }
}
