//
//  OnBoardingViewForth.swift
//  Criatu
//
//  Created by Luis Pereira on 26/11/20.
//

import SwiftUI

struct EndOnboardingView: View {
    var body: some View {
        
        ZStack {
            
            Color(.systemBackground).ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                Text("Agora é o momento de escolher seus interesses!!!").font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center).padding().foregroundColor(Color(.systemPurple))
                Spacer()
                Image("image_3").frame(alignment: .bottom)
                    .scaledToFit()
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .center)
        }

    }
}

struct EndOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        EndOnboardingView()
    }
}
