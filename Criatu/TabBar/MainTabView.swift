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
    
    var delegate: SelectedViewDelegate?
    /// Array containing all tabs titles
    
    var body: some View {
        VStack{
            HStack(spacing: 15) {
                Button(action:{
                    self.selectedView.index = 0
                    delegate?.changeSelectedIndex()
                }){
                    HStack {
                        
                        Text("Descubra").font(.system(size: 16, weight: .medium, design: .rounded))
                        
                    }.padding(15)
                    .background(self.selectedView.index == 0 ? Color(.systemPurple).opacity(0.2) : Color.clear)
                    .foregroundColor(self.selectedView.index == 0 ? Color(.systemPurple) : Color.secondary)
                    .clipShape(Capsule())
                }
                
                Button(action:{
                    self.selectedView.index = 1
                    delegate?.changeSelectedIndex()
                }){
                    HStack {
                        Text("Armários").font(.system(size: 16, weight: .medium, design: .rounded))
                        
                    }.padding(15)
                    .background(self.selectedView.index == 1 ? Color(.systemPurple).opacity(0.2) : Color.clear)
                    .foregroundColor(self.selectedView.index == 1 ? Color(.systemPurple) : Color.secondary)
                    .clipShape(Capsule())
                }
                
                
                Button(action:{
                    self.selectedView.index = 2
                    delegate?.changeSelectedIndex()
                }){
                    HStack {
                        Text("Perfil").font(.system(size: 16, weight: .medium, design: .rounded))
                        
                    }.padding(15)
                    .background(self.selectedView.index == 2 ? Color(.systemPurple).opacity(0.2) : Color.clear)
                    .foregroundColor(self.selectedView.index == 2 ? Color(.systemPurple) : Color.secondary)
                    .clipShape(Capsule())
                }
                
                
            }
            .frame(width: UIScreen.main.bounds.width)
            .padding(.vertical)
        }
        //.frame(height: 60, alignment: .center)
        //.animation(.default)
    }
    
}
