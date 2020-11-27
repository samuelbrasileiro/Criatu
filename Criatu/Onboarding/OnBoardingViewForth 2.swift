//
//  OnBoardingViewForth.swift
//  Criatu
//
//  Created by Luis Pereira on 26/11/20.
//

import SwiftUI

struct OnBoardingViewForth: View {
    var body: some View {
        
        ZStack {
            
            Color.backGroundColor.ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                Text("Agora é o momento de escolher seus interesses!!!").font(.largeTitle).fontWeight(.bold).multilineTextAlignment(.center).padding().foregroundColor(Color.titleColor)
                Spacer()
                Image("image_3").frame(alignment: .bottom)
                    .scaledToFit()
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }

    }
}

struct OnBoardingViewForth_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingViewForth()
    }
}
