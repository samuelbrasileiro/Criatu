//
//  CardView.swift
//  Criatu
//
//  Created by Luis Pereira on 24/11/20.
//

import SwiftUI

struct OnboardItemView: View {
    var titleText: String
    var descriptionText: String
    var imageName: String
    var disabled: Bool
    
    var delegate: OnboardingDelegate?
    
    var body: some View {
        VStack {
            
            HStack(alignment:.center, spacing: nil){
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: 50, alignment: .center)
            .disabled(!disabled)
            .opacity(disabled ? 1 : 0)
            
            Image(imageName).scaledToFit()
                .frame(idealWidth: 100, idealHeight: 100, maxHeight: 400)
            
            Spacer()
        ZStack{
            

            Rectangle()
                .fill(Color(.systemPurple).opacity(0.15))
                .cornerRadius(40, corners: [.topLeft, .topRight])
                .scaledToFill()
                .shadow(radius: 50)
                
            
            VStack {
                Text(titleText).foregroundColor(Color(.systemPurple))
                    .font(.title)
                    .bold()
                    .padding(.top, -20)
                    .padding(.bottom, 20)
                
                Text(descriptionText)
                    .font(.title2)
                    .multilineTextAlignment(.center)
                    .padding([.top, .leading, .trailing])
                
                Button(action: {
                    delegate?.finishOnboarding()
                }, label: {
                    Text("Começar")
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.systemBackground))
                })
                .foregroundColor(Color.primary)
                .padding(.vertical)
                .padding(.horizontal, 80)
                .background(Color(.systemPurple))
                .cornerRadius(10)
                .disabled(disabled)
                .opacity(disabled ? 0 : 1)
                .padding(.top, 40)
                
                Spacer()
                
            }.frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity, minHeight: 150, idealHeight: 200, maxHeight: 250, alignment: .center)
            
        }
        }
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardItemView(titleText: "Title", descriptionText: "Description", imageName: "image_1", disabled:false)
    }
}
