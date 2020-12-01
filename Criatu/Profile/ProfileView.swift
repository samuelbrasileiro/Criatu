//
//  ProfileView.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 30/11/20.
//

import SwiftUI

struct ProfileView: View {
    
    var name: String
    var wardrobe: String
    var descriptionText: String
    
    @State private var showNotification = true
    
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
                    //                        .position(x: 80, y: 55)
                    
                    HStack{
                        
                        // pesquisar como fazer com ForEach a partir da classe
                        //criar uma classe das cores que aceite a selecao de cores, vai ter a cor e se ta selecionado
                        Button(action: {
                        }, label: {
                            Circle()
                                .foregroundColor(Color(.systemPurple))
                                .frame(width: 40, height: 40, alignment: .center)
                            // no lugar de position eh melhor
                            
                        })
                        
                        Button(action: {
                        }, label: {
                            
                            Circle()
                                .foregroundColor(.blue)
                                .frame(width: 40, height: 40, alignment: .center)
                        })
                        
                        Button(action: {
                        }, label: {
                            Circle()
                                .foregroundColor(.red)
                                .frame(width: 40, height: 40, alignment: .center)
                            
                        })
                        
                        Button(action: {
                        }, label: {
                            Circle()
                                .foregroundColor(.green)
                                .frame(width: 40, height: 40, alignment: .center)
                        })
                        
                    }.padding()
                    
                    Text(descriptionText)
                        .font(.callout)
                        .fontWeight(.thin)
                        .italic()
                    
                    VStack {
                        Toggle(isOn: $showNotification) {
                            Text("Notificações")
                        }.padding()
                        
                        if showNotification {
                            Text("Vou pesquisar como fazer o coisa ainda kk")
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
        ProfileView(name: "Salumalatrix", wardrobe: "4", descriptionText: "Bela cor escolhida")
    }
}
