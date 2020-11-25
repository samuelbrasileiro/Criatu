//
//  TitleWardrobeView.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 23/11/20.
//

import SwiftUI

struct TitleWardrobeView: View {
    var body: some View {
        
            VStack{
                Text("Meus armários")
                    .font(.title)
                    .fontWeight(.semibold)
                    .multilineTextAlignment(.leading)
                    .padding(.bottom, 505.0)
            }
            .foregroundColor(.purple)
            
    }
    
    struct TitleWardrobeView_Previews: PreviewProvider {
        static var previews: some View {
            TitleWardrobeView()
            
        }
    }
}

