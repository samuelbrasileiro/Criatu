//
//  WardrobeView.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 24/11/20.
//

import SwiftUI

struct WardrobeView: View{
    
    @ObservedObject var style: Style
    
    @ObservedObject var palette = Palette.shared
    
    @State var showDetails: Bool = false
    var body: some View{
        ZStack(alignment: .topTrailing) {
            
            if !showDetails{
                
                NavigationLink(destination: ClosetView(style: style)) {
                    
                    ZStack(alignment: .bottom){
                        GeometryReader{ geometry in
                            if let image = style.image {
                                
                                Image(uiImage: image)
                                    .resizable()
                                    //.aspectRatio(contentMode: .fill)
                                    .edgesIgnoringSafeArea(.all)
                                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
                            }
                            else{
                                Rectangle()
                                    .foregroundColor(Color(.systemGray6))
                            }
                        }
                        
                        
                        ZStack(alignment: .bottomLeading){
                            Rectangle()
                                .frame(height: 68, alignment: .center)
                                
                                .foregroundColor(Color(.systemBackground))
                                
                            
                            Text(style.attributes.name)
                                .font(.largeTitle)
                                .fontWeight(.semibold)
                                .foregroundColor(palette.main)
                                .padding()
                            
                        }
                    }
                }
            }
            
            else {
                
                ZStack{
                    Rectangle()
                        .cornerRadius(20)
                        .foregroundColor(palette.main)
                    
                    Text(style.attributes.description)
                        .fontWeight(.regular)
                        .font(.system(size: 20, weight: .regular, design: .rounded))
                        .foregroundColor(Color(.systemBackground))
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 30.0)
                    
                    
                }
            }
            
            Button(action: {
                self.showDetails.toggle()
                
            }) {
                
                if showDetails{
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(Color(.systemBackground).opacity(0.7))
                }
                else{
                    Image(systemName: "info.circle.fill")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(palette.main)
                        .background(Circle().fill(Color(.systemBackground)))
                }
            }
            .accessibilityIdentifier("ClothingButton")
            .padding([.top, .trailing])
            
        }
        .cornerRadius(20)
        .shadow(radius: 20)
        
    }
}



struct WardrobeView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        
        WardrobeView(style: ClosetsBank().styles[0])
        
    }
}



