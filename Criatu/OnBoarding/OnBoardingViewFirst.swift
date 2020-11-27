//
//  OnBoardingViewFirst.swift
//  Criatu
//
//  Created by Luis Pereira on 23/11/20.
//

import SwiftUI


struct OnBoardingViewFirst: View {
    var body: some View {
        
        ZStack {
            Color.backGroundColor.ignoresSafeArea(.all, edges: .all)
            VStack {
                
                HStack(alignment:.center, spacing: nil){
                    
                    Spacer()
                    Button(action: {}, label: {
                        Text("Pular")
                            .multilineTextAlignment(.trailing)
                    })
                    .foregroundColor(Color.skipColor)
                    .padding()
                    
                }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Image("image_0").scaledToFit()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                CardView(titleText: "Descubra estilos!", descriptionText: "Por meio de cheiros, sons gostos e muitas outras coisas",disabled: true)
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
    
}

struct OnBoardingViewFirst_Previews: PreviewProvider {
    static var previews: some View {
        OnBoardingViewFirst()
    }
    
    
    
}

extension Color{
    static let backGroundColor = Color("backGround")
    static let cardColor = Color("cardColor")
    static let skipColor = Color("skipColor")
    static let titleColor = Color("titleColor")
    static let bodyTextColor = Color("bodyTextColor")
}


