//
//  WardrobeView.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 24/11/20.
//

import SwiftUI

struct WardrobeView: View {
    
    @State var backgroundColor: Color = Color(.systemGray5)
    @State private var showDetails = false
    
    
    //    @State var selected = self.
    
    var body: some View {
        
        VStack {
            
            Text("Meus armários")
                .font(.title)
                .foregroundColor(.purple)
                .fontWeight(.semibold)
                .multilineTextAlignment(.leading)
                .padding()
            
            ZStack {
                // o texto ta mais longe da gente, pois ta no comeco
                
                ZStack{
                    Image("granola-image").resizable().frame(width: 267, height: 410, alignment: .center)
                        .position(x: 175, y: 220)
                        .padding()
                    
                    ZStack{
                        Rectangle().frame(width: 385, height: 68, alignment: .center)
                            .cornerRadius(20, corners: [.bottomRight, .bottomLeft])
                            
                            .position(x: 144, y: 400)
                            .foregroundColor(.white).opacity(0.7)
                        
                        Text("Granola")
                            .font(.largeTitle)
                            .fontWeight(.medium)
                            .foregroundColor(Color.purple)
                            .multilineTextAlignment(.center)
                            .position(x: 190, y: 400)
                    }
                    
                }
                
                HStack{
                    
                    Button(action: {
                        withAnimation {
                            self.showDetails.toggle()
                        }
                    }) {
                        HStack{
                            Image(systemName: "info.circle.fill").resizable().frame(width: 25, height: 25)
                                .foregroundColor(Color.purple)
                                .position(x: 290, y: 80)
                        }
                    }
                    
                }
                
                if $showDetails.wrappedValue {
                    
                    ZStack{
                        Rectangle().frame(width: 267, height: 410, alignment: .center)
                            .cornerRadius(20)
                            .foregroundColor(.purple)
                        
                        Text("Um armário para aqueles que amam estar em contato com a natureza e, quando puder, tenha a certeza que vai estar.  Sempre com a cabeça nas nuvens, os granolas visam um visual mais imaginativo e natural, normalmente ecológico e vegano.")
                            .fontWeight(.regular)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30.0)
                            .frame(width: 267, height: 410, alignment: .center)
                        // .background(EmptyView()).opacity(0.95)
                        
                        Image(systemName: "xmark.circle.fill").resizable().frame(width: 25, height: 25)
                            .position(x: 290, y: 80)
                            .foregroundColor(.white)
                        
                    }
                }
            }
            
        }
    }
}


struct WardrobeView1: PreviewProvider {
    static var previews: some View {
        WardrobeView()
        
        
    }
}



