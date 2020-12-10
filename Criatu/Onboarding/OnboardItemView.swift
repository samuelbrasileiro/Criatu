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
    
    @ObservedObject var palette = Palette.shared
    
    var body: some View {
        VStack {
            
            HStack(alignment:.center, spacing: nil){
                Spacer()
            }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50, alignment: .center)
            .disabled(!disabled)
            .opacity(disabled ? 1 : 0)
            
            Image(imageName)
                .resizable()
                
                .frame(idealWidth: 100, idealHeight: 100, maxHeight: 400)
                .scaledToFit()
                .clipped()
            
            Spacer()
            ZStack{
                
                
                Rectangle()
                    .fill(Color(UIColor(palette.main).withAlphaComponent(0.3)))
                    .cornerRadius(40, corners: [.topLeft, .topRight])
                    
                    .scaledToFill()
                
                
                
                VStack {
                    Text(titleText).foregroundColor(palette.main)
                        .font(.title)
                        .bold()
                        .padding(.top, -20)
                        .padding(.bottom, 20)
                    
                    Text(descriptionText)
                        .font(.title2)
                        .multilineTextAlignment(.center)
                        .padding([.top, .leading, .trailing])
                    
                    NavigationLink(destination: EndOnboardingView(delegate: delegate)){
                        Text("Começar")
                            .multilineTextAlignment(.center)
                            .foregroundColor(Color(.systemBackground))
                            .padding(.vertical)
                            .padding(.horizontal, 80)
                            .background(palette.main)
                            .cornerRadius(10)
                            .disabled(disabled)
                            .opacity(disabled ? 0 : 1)
                            .padding(.top, 40)
                    }
                    .foregroundColor(Color.primary)
                    
                    
                    
                    Spacer()
                    
                }.frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity, minHeight: 150, idealHeight: 200, maxHeight: 250, alignment: .center)
                
            }
        }
        .background(Color(.systemGray6))
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardItemView(titleText: "Title", descriptionText: "Description", imageName: "image_1", disabled:false)
    }
}
