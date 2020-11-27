//
//  PageViewController.swift
//  Criatu
//
//  Created by Luis Pereira on 26/11/20.
//

import SwiftUI

struct OnboardingPageView: View {
    
    var body: some View {
        
        ZStack{
            TabView {
                
                CardView(titleText: "Descubra estilos!", descriptionText: "Por meio de cheiros, sons gostos e muitas outras coisas", imageName: "image_0", disabled: true)
                
                CardView(titleText: "Construa armários!", descriptionText:"Customize suas descobertas em armários que refletem sua personalidade", imageName: "image_1", disabled: true)
                
                CardView(titleText: "Organize os looks!", descriptionText: "A partir de sugestões, monte suas proprias gavetas!", imageName: "image_2", disabled: false)
                
            }
            .tabViewStyle(PageTabViewStyle())
            
            Button(action: {}, label: {
                Text("Pular")
                    .multilineTextAlignment(.trailing)
            })
            .foregroundColor(Color(.systemPurple))
            .padding()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        
    }
}

struct OnboardingPageViewPreviews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
