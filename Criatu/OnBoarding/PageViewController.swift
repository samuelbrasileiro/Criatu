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
            
        }
    }
}

struct PageViewController_Previews: PreviewProvider {
    static var previews: some View {
        PageViewController()
    }
}
