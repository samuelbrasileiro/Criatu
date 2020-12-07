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
    
    let screen = UIScreen.main.bounds
    
    @ObservedObject var palette = Palette.shared
    
    var body: some View {
        
        ZStack {
            if(suggestionIndex < style.suggestions.count){
            ZStack(alignment: .bottom) {
                    Image(uiImage: style.suggestions[suggestionIndex].image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: screen.width - 100, height: screen.height - 350, alignment: .center)
                        
                        .clipped()
                        .cornerRadius(20)
                        
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
                                .foregroundColor(palette.main.opacity(0.8))
                                .background(Circle().fill(Color(.systemGray6)))
                            
                            
                        }
                        
                        Button(action: {
                            isLiked = true
                        }) {
                            Image(systemName: "heart.circle.fill")
                                .resizable()
                                .frame(width: 70, height: 70)
                                .foregroundColor(palette.main)
                                .background(Circle().fill(Color(.systemGray6)))
                            
                            
                        }
                    }
                }
                .padding(.bottom, 60)
                    .blur(radius: isLiked ? 3.0 : 0)
                    .disabled(isLiked)
            }
            else{
                Text("Acabaram as sugestões de estilo \(style.attributes.name.lowercased()) por hoje. Volte mais tarde para mais!")
                    .foregroundColor(Color(.systemGray4))
                .padding(100)
            }
            SaveItemAlertView(isPresented: $isLiked, style: style, suggestionIndex: suggestionIndex)
        }
        
        .resingKeyboardOnTapGesture()
        
    }
}

struct SaveItemAlertView: View {
    
    @Binding var isPresented: Bool
    @ObservedObject var style: Style
    @State var suggestionIndex: Int
    
    @State var newDrawerName: String = ""
    
    @State var isCreatingNewCloset: Bool = false
    @ObservedObject var palette = Palette.shared
    var body: some View {
        ZStack{
            VStack(alignment: .leading){
                HStack(alignment: .top){
                    Text("Em qual gaveta você quer guardar esse look?")
                        .bold()
                        .foregroundColor(palette.main)
                        .padding(.top, 10)
                    Spacer()
                    Button(action:{
                        isPresented = false
                    }){
                        Image(systemName: "xmark.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(palette.main)
                        
                    }
                }
                if !isCreatingNewCloset{
                    Button(action:{
                        isCreatingNewCloset = true
                    }){
                        HStack{
                            Text("Nova gaveta")
                            
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 14, height: 14)
                                .padding(.leading)
                        }
                        .padding(7)
                        .background(palette.main)
                        .foregroundColor(Color(.systemGray6))
                        .cornerRadius(10)
                    }
                    .padding(.bottom)
                    
                    ScrollView{
                        LazyVStack(alignment: .leading, spacing: 10){
                            ForEach(0..<style.drawers.count, id: \.self){index in
                                Button(action:{
                                    style.addLookToDrawer(drawerIndex: index, lookIndex: suggestionIndex)
                                    isCreatingNewCloset = false
                                    isPresented = false
                                }){
                                    Text(style.drawers[index].name ?? "")
                                }
                            }
                        }
                    }
                }
                else{
                    VStack{
                        TextField("Qual vai ser o nome?", text: $newDrawerName)
                            .foregroundColor(.primary)
                            .padding(7)
                            .background(Color(.systemBackground))
                            .cornerRadius(10)
                        Spacer()
                        Button(action:{
                            if !newDrawerName.isEmpty{
                                style.createDrawer(name: newDrawerName)
                                isCreatingNewCloset = false
                                newDrawerName = ""
                            }
                        }){
                            Text("Criar gaveta")
                                .padding(7)
                                .background(palette.main)
                                .foregroundColor(Color(.systemGray6))
                                .cornerRadius(10)
                        }
                        .padding(.bottom)
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
