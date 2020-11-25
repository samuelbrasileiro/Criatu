//
//  TabBarViewController.swift
//  Criatu
//
//  Created by Beatrix Lee on 24/11/20.
//

import Foundation
import SwiftUI

struct TabBarView: View {
    
    @State var index = 0
    @ObservedObject var bank: DiscoverBank


    var body: some View {
        
        VStack {
            
            ZStack {
                
                if self.index == 0 {
                    
                    DiscoverView(bank: bank)

                }
                
                else if self.index == 1 {
                    
                    Color.red.edgesIgnoringSafeArea(.all)
                    
                } else {
                    
                    Color.blue.edgesIgnoringSafeArea(.all)
                }
            }
            TabBarViewController(index: $index)
        }.animation(.spring())
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(bank: DiscoverBank())
    }
}

struct TabBarViewController: View {
    
    @Binding var index: Int
    
    /// Array containing all tabs titles
    
    var body: some View {
        
        HStack(spacing: 15) {
            HStack {
                
                Text(self.index == 0 ? "Descubra" : "Descubra").font(.system(size: 16, weight: .medium, design: .rounded))
                
            }.padding(15)
            .background(self.index == 0 ? Color.purple.opacity(0.2) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 0
            }
            
            HStack {
                Text(self.index == 1 ? "Armários" : "Armários").font(.system(size: 16, weight: .medium, design: .rounded))
                
            }.padding(15)
            .background(self.index == 1 ? Color.purple.opacity(0.2) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 1
            }
            
            HStack {
                
                Text(self.index == 2 ? "Perfil" : "Perfil").font(.system(size: 16, weight: .medium, design: .rounded))
                
            }.padding(15)
            .background(self.index == 2 ? Color.purple.opacity(0.2) : Color.clear)
            .clipShape(Capsule())
            .onTapGesture {
                self.index = 2
            }
            
        }.padding(8)
        .frame(width: UIScreen.main.bounds.width)
        .background(Color.white.opacity(0.86))
        .frame(minWidth: 375, idealWidth: 375, maxWidth: 375, minHeight: 60, idealHeight: 60, maxHeight: 60, alignment: .center)
        .animation(.default)
    }
    
}
