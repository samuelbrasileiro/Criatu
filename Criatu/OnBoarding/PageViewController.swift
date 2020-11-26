//
//  PageViewController.swift
//  Criatu
//
//  Created by Luis Pereira on 26/11/20.
//

import SwiftUI

struct PageViewController: View {
    
    
    var body: some View {
        
        ZStack {
            Color.backGroundColor.ignoresSafeArea(.all, edges: .all)
            TabView {
                OnBoardingViewFirst()
                OnBoardingViewSecond()
                OnBoardingViewThird()
            }.tabViewStyle(PageTabViewStyle())
            .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
        }
    }
}

struct PageViewController_Previews: PreviewProvider {
    static var previews: some View {
        PageViewController()
    }
}
