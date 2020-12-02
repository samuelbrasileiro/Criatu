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
        
        ZStack {
            ZStack(alignment: .bottom) {
                
                Image(uiImage: style.suggestions[suggestionIndex].image)
                    .resizable()
                    //                .frame(width: 292, height: 486, alignment: .center)
                    .cornerRadius(20)
                    .aspectRatio(CGSize(width: 3, height: 5.5), contentMode: .fill)
                    .padding(.horizontal, 60)
                    .padding(.bottom)
                
                
                HStack(spacing: 70) {
                    Button(action: {
                        
                        if suggestionIndex < self.style.suggestions.count - 1 {
                            self.style.suggestions.remove(at: suggestionIndex)
                        }
                        
                    }) {
                        
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color(.systemPurple).opacity(0.8))
                            .background(Circle().fill(Color(.white)))
                        
                        
                    }
                    
                    Button(action: {
                        isLiked = true
                    }) {
                        Image(systemName: "heart.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color(.systemPurple))
                            .background(Circle().fill(Color(.white)))
                        
                        
                    }
                }
            }
            .padding(.bottom, 60)
        }
        
        SaveItemAlertView(isPresented: $isLiked, style: style, suggestionIndex: suggestionIndex)
        
        //        .navigationBarTitle("Sugestões")
    }
}

struct SaveItemAlertView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var style: Style
    @State var suggestionIndex: Int
    
    var body: some View {
        VStack {
            Text("Em qual gaveta você quer guardar esse look?")
            
        }
        .padding()
        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.3)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .offset(y: isPresented ? 0 : UIScreen.main.bounds.height)
        .animation(.spring())
        .shadow(color: Color(.systemGray6), radius: 6, x: -9, y: -9)
    }
}

//
//struct SaveLooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveLooksView(style: sty, suggestionIndex: 0)
//    }
//}
