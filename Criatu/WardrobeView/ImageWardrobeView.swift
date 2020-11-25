////
////  ImageWardrobeView.swift
////  Criatu
////
////  Created by Alanis Lima Santa Clara on 23/11/20.
////
//
//import SwiftUI
//
//struct ImageWardrobeView: View {
//    
//    @State var backgroundColor: Color = Color(.systemGray5)
//    @State private var showDetails: Bool
//    
//    var body: some View {
//        
//        VStack {
//            
//            ZStack {
//                Image("granola-image").resizable().frame(width: 267, height: 410, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                //.position(x: 51, y: 171)
//                
//                
//                
//                ZStack {
//                    Button(action: {
//                        self.showDetails.toggle()
//                        //talvez esconder a imagem de baixo
//                    }) {
//                        HStack{
//                            Image("granola-image").resizable().frame(width: 267, height: 410, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
//                                .padding(.horizontal, 30.0)
//                            
//                            HStack{
//                                
//                                Rectangle().frame(width: 260, height: 68, alignment: .center)
//                                    .cornerRadius(20, corners: [.bottomRight, .bottomLeft])
//                                    
//                                    .position(x: 144, y: 421)
//                                    .foregroundColor(.white).opacity(0.7)
//                                
//                                Text("Granola")
//                                    .font(.largeTitle)
//                                    .fontWeight(.medium)
//                                    .foregroundColor(Color.purple)
//                                    .multilineTextAlignment(.center)
//                                    .position(x: 144, y: 421)
//                            }
//                        }
//                    }
//                    if showDetails {
//                        //Text("Mudar de tela para dentro desse armario")
//                        //   .font(.largeTitle)
//                    }
//                }
//                
//                ZStack{
//                    Button(action: {
//                        self.showDetails.toggle()
//                    }) {
//                        
//                        Image(systemName: "info.circle.fill").resizable().frame(width: 25, height: 25)
//                            .foregroundColor(.purple)
//                            .position(x: 240, y: 100)
//                    }
//                    
//                    if showDetails {
//                        InfoWardrobeView().animation(.default)
//                        
//                    }
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//struct ImageWardrobeView_Previews: PreviewProvider {
//    static var previews: some View {
//        ImageWardrobeView()
//    }
//}

