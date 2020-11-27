//
//  WardrobeView.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 24/11/20.
//

import SwiftUI

struct WardrobeView: View{
    
    @ObservedObject var style: Style
    
    @State var showDetails: Bool = false
    
    var body: some View{
        ZStack(alignment: .topTrailing) {
            
            if !showDetails{
                
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
                    
                    ZStack(alignment: .center){
                        Rectangle()
                            .frame(height: 68, alignment: .center)
                            
                            .foregroundColor(Color(.systemBackground))
                            .opacity(0.7)
                            .blur(radius: 7)
                        
                        Text(style.attributes.name)
                            .font(.largeTitle)
                            .fontWeight(.semibold)
                            .foregroundColor(Color(.systemPurple))
                        
                    }
                    
                }
            }
            
            else {
                
                ZStack{
                    Rectangle()
                        .cornerRadius(20)
                        .foregroundColor(Color(.systemPurple))
                    
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
                        .foregroundColor(Color(.systemPurple))
                }
            }
            .padding([.top, .trailing])
            
        }
        .frame(width: 240, height: 420)
        .cornerRadius(20)
        .shadow(radius: 20)
    }
}


struct WardrobesView: View {
    

    @ObservedObject var bank: ClosetsBank
    
    var body: some View {
        
        VStack {
            
            Text("Meus armários")
                .font(.title)
                .foregroundColor(Color(.systemPurple))
                .fontWeight(.semibold)
                .padding(.top, 40)
            
            Spacer()

            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 55) {
                    ForEach(0..<bank.styles.count) { index in
                        WardrobeView(style: bank.styles[index])
                    }
                }.padding(.leading, 70)
                
            }
            Spacer()
            Spacer()
        }.background(Color(.systemGray6))
        
    }
}


struct WardrobesView_PreviewProvider: PreviewProvider {
    static var previews: some View {
        
        WardrobesView(bank: ClosetsBank())
        WardrobeView(style: ClosetsBank().styles[0])
        
    }
}



