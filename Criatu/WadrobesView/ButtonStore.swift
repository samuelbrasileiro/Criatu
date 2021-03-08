//
//  ButtonStore.swift
//  Criatu
//
//  Created by Hugo Santos on 01/03/21.
//


// - - - - - - - - - - - - - - - -Add this code in anyview to add this kind of button- - - - - - - - - - - - - - -
//  @Environment(\.openURL) var openURL - you need to create this var too.
//ButtonStore(action: { print("pegou"); openURL(URL(string: "https://www.instagram.com/vila.morato/")!)}) {
//    Text("Visitar Loja")
//        .fontWeight(.none)
//        .foregroundColor(Color.purple)
//}
//.buttonStyle(PrimaryButtonStyle())
// - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

import SwiftUI


struct ButtonStore<WhateverYouWant: View>: View {
    let action: () -> Void
    let content: WhateverYouWant
    @ObservedObject var palette = Palette.shared
    init(action: @escaping () -> Void, @ViewBuilder content: () -> WhateverYouWant){
        
        self.action = action
        self.content = content()
    }

    @Environment(\.openURL) var openURL
    
    var body: some View {
        
        Button(action: action){
            content
                .padding(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        //.stroke(Color.purple, lineWidth: 3))
                        .stroke(palette.main, lineWidth: 3))
        }
    }
    
}

struct PrimaryButtonStyle: ButtonStyle {
    
    @ObservedObject var palette = Palette.shared
    
    func makeBody(configuration: Self.Configuration) ->  some View {
        
        configuration.label
            //.background(configuration.isPressed ? Color.purple : Color.white)
            //.foregroundColor(palette.main)
            .background(configuration.isPressed ? palette.main : Color.white)
            .cornerRadius(10)
            .padding()
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity)
            .opacity(configuration.isPressed ? 0.7 : 1)
    }
}
