//
//  WardrobesView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 27/11/20.
//

import SwiftUI

struct WardrobesView: View {
    
    @ObservedObject var bank: ClosetsBank
    
    @ObservedObject var palette = Palette.shared
    
    var body: some View {
        NavigationView{
            VStack {
                if bank.styles.count > 0 {
                    LazySnapHStack(data: bank.styles){ item in
                        
                        WardrobeView(style: item)
                            
                    }
                    Spacer()
                }
                else{
                    Spacer()
                    Text("Você ainda não descobriu nenhum armário... Quando você descobrir um, ele aparecerá aqui!")
                        .foregroundColor(Color(.systemGray3))
                    .padding(100)
                    Spacer()
                }
                
            }
            .navigationBarTitle("Meus Armários")
            .background(Color(.systemGray6))
            .onAppear{
                bank.getStyles()
            }
        }.accentColor(palette.main)
        .navigationViewStyle(StackNavigationViewStyle())
        
    }
}

struct WardrobesView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        
        WardrobesView(bank: ClosetsBank())
        
    }
}
