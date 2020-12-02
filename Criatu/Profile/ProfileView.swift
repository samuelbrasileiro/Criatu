//
//  ProfileView.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 30/11/20.
//

import SwiftUI



struct ProfileView: View {
    
    
    let colors: [Color] = [Color(.systemPurple), Color(.systemBlue), Color(.systemRed), Color(.systemGreen)]
    let descriptionText: [String] = ["Roxo Elétrico", "Ciano Sombrio","Vermelho Melancia","Verde Amoeba"]
    
    
    var name: String
    var wardrobe: String
    
    @State var selectedIndex = 0
    @State var showNotification = true
    @State var changeColors = true
    
    var body: some View {
        VStack{
            
            Text("Olá, " + name)
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color.purple)
                .padding(.bottom, 10.0)
            
            
            Text("Até o momento você já descobriu ")
                .padding(10.0)
            
            Text(wardrobe)
                .font(.largeTitle)
                .fontWeight(.black)
                .padding(20.0)
            
            Text("Armários")
                .font(.headline)
                .fontWeight(.medium)
                .padding(10.0)
            
            Spacer()
            
            ZStack{
                
                Rectangle()
                    .fill(Color(.systemGray6).opacity(0.9))
                    .cornerRadius(40, corners: [.topLeft, .topRight])
                    .shadow(radius: 15).opacity(0.9)
                
                VStack(alignment: .leading){
                    Text("Cor do tema")
                        .font(.title3)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                        .padding()
                    //                        .position(x: 80, y: 55)
                    
                    HStack{
                        ForEach(0..<colors.count, id: \.self) { index in
                            
                            Button(action: {
                                selectedIndex = index
                            }, label: {
                                if selectedIndex == index{
                                    
                                    
                                    VStack(){
                                        Circle()
                                            .foregroundColor(colors[index])
                                            //                                            .border(Color.black, width: 2)
                                            .frame(width: 40, height: 40, alignment: .center)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(colors[index], lineWidth: 5)
                                            )
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 20)
                                                    .stroke(Color(.systemGray6), lineWidth: 1)
                                            )
                                        
                                        
                                        
                                        
                                    }
                                    //                        ZStack{
                                    //                            Circle().foregroundColor(.black)
                                    //                                .frame(width: 50, height: 50, alignment: .center)
                                    //                        }
                                }
                                else{
                                    
                                    
                                    
                                    VStack{
                                        Circle().foregroundColor(colors[index])
                                            .frame(width: 40, height: 40, alignment: .center)
                                        
                                    }
                                }
                            })
                        }
                        
                    }.padding()
                    
                    Text("\(descriptionText[selectedIndex])" + " é o seu tema no momento")
                        .font(.footnote)
                        .fontWeight(.thin)
                        .italic()
                        .padding(.leading)
                        .foregroundColor(Color(.systemGray))
                        .lineLimit(1)
                    
                    
                    VStack {
                        Toggle(isOn: $showNotification) {
                            Text("Notificações")
                        }.padding()
                        
                        if showNotification {
                        }
                    }
                    
                    VStack() {
                        
                        Text("Interesses")
                        //ver o navigationlink aqui
                    }.padding()
                    
                    
                    
                    
                    
                }.frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity, minHeight: 250, idealHeight: 400, maxHeight: 500, alignment: .center)
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(name: "Salumalatrix", wardrobe: "4")
    }
}
