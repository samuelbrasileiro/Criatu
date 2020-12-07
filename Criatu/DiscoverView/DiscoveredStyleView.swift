//
//  DiscoveredStyleView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 07/12/20.
//

import SwiftUI

struct DiscoveredStyleView: View {
    @ObservedObject var style: Style
    var body: some View {
        
        VStack{
            Spacer()
            HStack{
                Spacer()
                WardrobeView(style: style)
                    .frame(width: UIScreen.main.bounds.width - 50, height: 500)
                Spacer()
            }
            Spacer()
        }
        .background(Color(.systemGray6))
        .navigationBarTitle("Novo Estilo!")
        .navigationBarHidden(false)
    }
}

