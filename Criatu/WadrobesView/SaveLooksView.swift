//
//  SaveLooksView.swift
//  Criatu
//
//  Created by Beatrix Lee on 01/12/20.
//

import SwiftUI

struct SaveLooksView: View {
    
    @ObservedObject var style: Style
    
    @State var isLiked: Bool = false
    @State var suggestionIndex: Int 
    
    var body: some View {
        
        VStack {
            Spacer()
            ZStack(alignment: .bottom) {
                
                Image(uiImage: style.suggestions[suggestionIndex].image)
                    .resizable()
                    .frame(idealWidth: 292, minHeight: 486, alignment: .center)
                    .cornerRadius(20)
                    .padding([.bottom, .top])
                    
                
                HStack {
                    Button(action: {
                        
                    }) {
                      
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color(.systemPurple).opacity(0.8))
                            .padding(40)
                            .padding([.bottom, .trailing])
                        
                        
                    }
                    
                    Button(action: {
                        
                    }) {
                        Image(systemName: "heart.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color(.systemPurple))
                            .padding(40)
                            .padding([.bottom, .trailing])
                            
                    }
                }
            }
            Spacer()
        }
    }
}

//
//struct SaveLooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveLooksView(style: sty, suggestionIndex: 0)
//    }
//}
