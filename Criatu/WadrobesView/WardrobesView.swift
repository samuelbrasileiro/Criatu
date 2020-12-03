//
//  WardrobesView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 27/11/20.
//

import SwiftUI

struct WardrobesView: View {
    
    @ObservedObject var bank: ClosetsBank
    
    var body: some View {
        NavigationView{
            VStack {
                if bank.styles.count > 0 {
                    LazySnapHStack(data: bank.styles){ item in
                        
                        WardrobeView(style: item)
                            .navigationBarTitle("Meus Armários")
                            .foregroundColor(.black)
                    }
                }
                
                Spacer()
            }
            .background(Color(.systemGray6))
            
        }.accentColor(Color(.systemPurple))
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

struct WardrobesView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        
        WardrobesView(bank: ClosetsBank())
        
    }
}
