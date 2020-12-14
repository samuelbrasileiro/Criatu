//
//  AppDelegate.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 27/11/20.
//

import SwiftUI

class SnapInfo: ObservableObject{
    @Published var offset : CGFloat = 0
    @Published var width = UIScreen.main.bounds.width - 50
    @Published var height: CGFloat = UIScreen.main.bounds.height - 220
    @Published var op : CGFloat = 0
    
    @Published var count : CGFloat = 0
    @Published var isDisplayed: [Bool] = []
    
    func updateStartPoint(count: Int){
        
        self.op = ((self.width + 15) * CGFloat(count / 2)) - (count % 2 == 0 ? ((self.width + 15) / 2) : 0)
        
        print("op: ", self.op, "count: ", self.count)
        
    }
    func updateIsDisplayed(count: Int){
        self.isDisplayed = (0..<count).map{_ in
            return false
        }
        if count < isDisplayed.count {
            self.isDisplayed[Int(count)] = true
        }
    }
    func updateHeight(value : Int){
        
        for i in 0..<isDisplayed.count{
            
            self.isDisplayed[i] = false
        }
        if value < isDisplayed.count{
            self.isDisplayed[value] = true
        }
    }
    
    func getIsDisplayed(of index: Int) -> Bool{
        if isDisplayed.count > index{
            return isDisplayed[index]
        }
        else{
            return false
        }
    }
}


struct LazySnapHStack<Elements, Content>: View
where Elements: RandomAccessCollection, Content: View {
    
    var data: Elements
    
    @ObservedObject var info: SnapInfo
    var content: (Elements.Element) -> Content
    
    
    var body : some View{
        
        LazyHStack(spacing: 15){
            
            ForEach(0..<self.data.count, id: \.self){index in
                
                content(data[index as! Elements.Index])
                    .frame(width: info.width, height: (self.info.getIsDisplayed(of: index) ? info.height : info.height - 40))
                    .offset(x: self.info.offset)
                    .highPriorityGesture(
                        DragGesture()
                            .onChanged({ (value) in
                                
                                if value.translation.width > 0{
                                    
                                    self.info.offset = value.location.x
                                }
                                else{
                                    
                                    self.info.offset = value.location.x - self.info.width
                                }
                                
                            })
                            .onEnded({ (value) in
                                
                                if value.translation.width > 0{
                                    
                                    if value.translation.width > ((self.info.width - 80) / 2) && Int(self.info.count) != 0{
                                        
                                        self.info.count -= 1
                                        self.info.updateHeight(value: Int(self.info.count))
                                        self.info.offset = -((self.info.width + 15) * self.info.count)
                                    }
                                    else{
                                        
                                        self.info.offset = -((self.info.width + 15) * self.info.count)
                                    }
                                }
                                else{
                                    
                                    if -value.translation.width > ((self.info.width - 80) / 2) && Int(self.info.count) !=  (self.data.count - 1){
                                        
                                        self.info.count += 1
                                        self.info.updateHeight(value: Int(self.info.count))
                                        self.info.offset = -((self.info.width + 15) * self.info.count)
                                    }
                                    else{
                                        
                                        self.info.offset = -((self.info.width + 15) * self.info.count)
                                    }
                                }
                            })
                    )
            }
        }
        .frame(width: UIScreen.main.bounds.width)
        .offset(x: self.info.op)
        .animation(.spring())
        .onAppear{
            info.updateIsDisplayed(count: data.count)
        }
        
    }
    
}
