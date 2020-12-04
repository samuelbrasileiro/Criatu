//
//  TabBarViewController.swift
//  Criatu
//
//  Created by Beatrix Lee on 24/11/20.
//

import Foundation
import SwiftUI


struct MainTabView: View {
    
    @ObservedObject var selectedView: SelectedView
    
    @ObservedObject var palette = Palette.shared
    
    var delegate: SelectedViewDelegate?
    /// Array containing all tabs titles
    
    var body: some View {
        VStack{
            HStack(spacing: 15) {
                
                ForEach((0..<selectedView.items.count)) { index in
                    
                    Button(action:{
                        self.selectedView.index = index
                        delegate?.changeSelectedIndex()
                        
                    }){
                        
                        Text(selectedView.items[index].name)
                            .font(.system(size: 16, weight: .medium, design: .rounded))
                            .padding(15)
                            .background(self.selectedView.index == index ? palette.main.opacity(0.2) : Color.clear)
                            .foregroundColor(self.selectedView.index == index ? palette.main : Color.secondary)
                            .clipShape(Capsule())
                    }
                }
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.vertical)
        }
        //.frame(height: 60, alignment: .center)
        //.animation(.default)
    }
    
}
