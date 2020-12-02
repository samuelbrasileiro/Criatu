//
//  testeaq.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 01/12/20.
//

import SwiftUI


struct ContentView: View {
    var body: some View {
        NavigationView {
            HStack{
                Text("Interesses")
                    .padding()
                Spacer()
                Image(systemName: "magnifyingglass")
                    .padding()
            }
        }
    }
}


struct testeaq_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


