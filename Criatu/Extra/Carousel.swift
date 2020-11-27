////
////  SnapCarousel.swift
////  prototype5
////
////  Created by xtabbas on 5/7/20.
////  Copyright © 2020 xtadevs. All rights reserved.
////
//import SwiftUI
//
//struct ContentView: View {
//    var body: some View {
//           
//        Home()
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
//
//struct Home : View {
//    
//    @State var x : CGFloat = 0
//    @State var count : CGFloat = 0
//    @State var screen = UIScreen.main.bounds.width - 30
//    @State var op : CGFloat = 0
//    
//    @State var bank: ClosetsBank
//    var body : some View{
//        
//        NavigationView{
//            
//            VStack{
//                
//                Spacer()
//                
//                HStack(spacing: 15){
//                    
//                    ForEach(bank.styles){style in
//                        
//                        WardrobeView(style: style)
//                            
//                        .offset(x: self.x)
//                        .highPriorityGesture(DragGesture()
//                        
//                            .onChanged({ (value) in
//                                
//                                if value.translation.width > 0{
//                                    
//                                    self.x = value.location.x
//                                }
//                                else{
//                                    
//                                    self.x = value.location.x - self.screen
//                                }
//                                
//                            })
//                            .onEnded({ (value) in
//
//                                if value.translation.width > 0{
//                                    
//                                    
//                                    if value.translation.width > ((self.screen - 80) / 2) && Int(self.count) != 0{
//                                        
//                                        
//                                        self.count -= 1
//                                        self.updateHeight(value: Int(self.count))
//                                        self.x = -((self.screen + 15) * self.count)
//                                    }
//                                    else{
//                                        
//                                        self.x = -((self.screen + 15) * self.count)
//                                    }
//                                }
//                                else{
//                                    
//                                    
//                                    if -value.translation.width > ((self.screen - 80) / 2) && Int(self.count) !=  (self.data.count - 1){
//                                        
//                                        self.count += 1
//                                        self.updateHeight(value: Int(self.count))
//                                        self.x = -((self.screen + 15) * self.count)
//                                    }
//                                    else{
//                                        
//                                        self.x = -((self.screen + 15) * self.count)
//                                    }
//                                }
//                            })
//                        )
//                    }
//                }
//                .frame(width: UIScreen.main.bounds.width)
//                .offset(x: self.op)
//                
//                Spacer()
//            }
//            .background(Color.black.opacity(0.07).edgesIgnoringSafeArea(.bottom))
//            .navigationBarTitle("Carousel List")
//            .animation(.spring())
//            .onAppear {
//                
//                self.op = ((self.screen + 15) * CGFloat(self.data.count / 2)) - (self.data.count % 2 == 0 ? ((self.screen + 15) / 2) : 0)
//                
//                self.data[0].show = true
//            }
//        }
//    }
//    
//    func updateHeight(value : Int){
//        
//        
//        for i in 0..<data.count{
//            
//            data[i].show = false
//        }
//        
//        data[value].show = true
//    }
//}
