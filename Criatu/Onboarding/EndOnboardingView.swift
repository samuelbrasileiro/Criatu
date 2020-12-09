//
//  OnBoardingViewForth.swift
//  Criatu
//
//  Created by Luis Pereira on 26/11/20.
//

import SwiftUI

struct EndOnboardingView: View {
    @ObservedObject var palette = Palette.shared
    var delegate: OnboardingDelegate?
    
    var body: some View {
        
        ZStack {
            
            Color(.systemGray6).ignoresSafeArea(.all, edges: .all)
            
            VStack {
                Spacer()
                Text("Agora é o momento de escolher os seus interesses!")
                    .font(.system(size: 30, weight: .bold, design: .rounded))
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .padding(40)
                    .foregroundColor(palette.main)
                Spacer()
                Image("logo")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)
                    
                
            }.frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment: .center)
        }
        .navigationBarHidden(true)
        .onAppear{
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false){_ in
                delegate?.finishOnboarding()
            }
        }

    }
}

struct EndOnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        EndOnboardingView()
    }
}
