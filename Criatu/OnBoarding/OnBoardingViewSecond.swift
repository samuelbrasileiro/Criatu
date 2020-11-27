//
//  OnBoardingViewSecond.swift
//  Criatu
//
//  Created by Luis Pereira on 24/11/20.
//

import SwiftUI


struct OnBoardingViewSecond: View {
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
                
                Image("image_1").scaledToFit()
                    .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: 400, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                CardView(titleText: "Construa armários!", descriptionText:"Customize suas descobertas em armários que refletem sua personalidade",disabled: true)
              
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
    
}
struct OnBoardingViewSecond_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            OnBoardingViewSecond()
            
        }
    }
    
    
    
}

