//
//  PageViewController.swift
//  Criatu
//
//  Created by Luis Pereira on 26/11/20.
//

import SwiftUI

struct OnboardingPageView: View {
    
    var delegate: OnboardingDelegate?
    
    @ObservedObject var palette = Palette.shared
    
    var body: some View {
        NavigationView{
            ZStack(alignment: .topTrailing){
                
                TabView {
                    
                    OnboardItemView(titleText: "Descubra estilos!", descriptionText: "Por meio de cheiros, sons gostos e muitas outras coisas", imageName: "image_0", disabled: true, delegate: delegate)
                    
                    OnboardItemView(titleText: "Construa armários!", descriptionText:"Customize suas descobertas em armários que refletem sua personalidade", imageName: "image_1", disabled: true, delegate: delegate)
                    
                    OnboardItemView(titleText: "Organize os looks!", descriptionText: "A partir de sugestões, monte suas proprias gavetas!", imageName: "image_2", disabled: false, delegate: delegate)
                    
                }
                .tabViewStyle(PageTabViewStyle())
                .padding(.bottom, 70)
                .navigationBarHidden(true)
                
                NavigationLink(destination: EndOnboardingView(delegate: delegate)){
                    Text("Pular")
                        .padding()
                        .padding(.top)
                        
                }
                .foregroundColor(palette.main)
                .padding()
                .navigationBarHidden(true)
                
            }
            .background(Color(.systemGray6))
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
        .ignoresSafeArea(.all, edges: .top)
        
        
    }
    
    
}

struct OnboardingPageViewPreviews: PreviewProvider {
    static var previews: some View {
        OnboardingPageView()
    }
}
