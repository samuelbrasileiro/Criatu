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
                            .background(Circle().fill(Color(.systemGray6)))
                        
                        
                    }
                    
                    Button(action: {
                        isLiked = true
                    }) {
                        Image(systemName: "heart.circle.fill")
                            .resizable()
                            .frame(width: 70, height: 70)
                            .foregroundColor(Color(.systemPurple))
                            .background(Circle().fill(Color(.systemGray6)))
                        
                        
                    }
                }
            }
            .padding(.bottom, 60)
            .blur(radius: isLiked ? 3.0 : 0)
            SaveItemAlertView(isPresented: $isLiked, style: style, suggestionIndex: suggestionIndex)
        }
        
        
        
        //        .navigationBarTitle("Sugestões")
    }
}

struct SaveItemAlertView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var style: Style
    @State var suggestionIndex: Int
    
    var body: some View {
        ZStack{
            VStack{
                HStack(alignment: .top){
                    Text("Em qual gaveta você quer guardar esse look?")
                        .bold()
                        .foregroundColor(Color(.systemPurple))
                        .padding(.top, 10)
                    Spacer()
                    Button(action:{
                        isPresented = false
                    }){
                    Image(systemName: "xmark.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(Color(.systemPurple))
                    }
                }
                Spacer()
            
            }
            
        }
        .padding(10)
        .frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.3)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .offset(y: isPresented ? 0 : UIScreen.main.bounds.height)
        .animation(.spring())
        .shadow(color: Color(.systemGray6), radius: 6, x: -7, y: 7)
    }
}

//
//struct SaveLooksView_Previews: PreviewProvider {
//    static var previews: some View {
//        SaveLooksView(style: sty, suggestionIndex: 0)
//    }
//}
