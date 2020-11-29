//
//  WardrobesView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 27/11/20.
//

import SwiftUI

struct WardrobesView: View {
    
    @ObservedObject var bank: ClosetsBank
    
    @State var isSelected: Int? = 0
    
    @State var selectedStyle: Style?
    var body: some View {
        NavigationView{
            VStack {
                

                LazySnapHStack(data: bank.styles){ item in
                    Button(action:{
                        selectedStyle = item
                        isSelected = 1
                    }) {
                        WardrobeView(style: item)
                    }.navigationBarTitle("Meus Armários")
                    .foregroundColor(.black)
                }
                
                Spacer()
            }
            .background(Color(.systemGray6))
            .onAppear{
                isSelected = 0
            }
        }.accentColor(Color(.systemPurple))
        
    }
}

struct WardrobesView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        
        WardrobesView(bank: ClosetsBank())
        
    }
}
