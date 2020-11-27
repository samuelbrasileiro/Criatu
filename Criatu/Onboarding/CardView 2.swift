//
//  CardView.swift
//  Criatu
//
//  Created by Luis Pereira on 24/11/20.
//

import SwiftUI

struct CardView: View {
    var titleText:String
    var descriptionText:String
    var disabled:Bool
    var body: some View {
        ZStack{
            
            
            
            Rectangle()
                .fill(Color.cardColor)
                .cornerRadius(40)
                .scaledToFill()
                .shadow(radius: 50)
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .infinity, alignment:.center)
            
            VStack {
                Text(titleText).foregroundColor(Color.titleColor)
                    .font(.title)
                
                Divider()
                
                Text(descriptionText).foregroundColor(Color.bodyTextColor).font(.title2).multilineTextAlignment(.center).padding([.top, .leading, .trailing])
                
                Divider()
                Divider()
                
                Button(action: {}, label: {
                    Text("Comece")
                        .multilineTextAlignment(.center)
                })
                .padding(.all)
                .foregroundColor(Color.backGroundColor)
                .frame(minWidth: 262, idealWidth: 300, maxWidth:300)
                .background(Color.titleColor)
                .cornerRadius(10)
                .disabled(disabled)
                .opacity(disabled ? 0:1)
                
                Spacer()
                
            }.frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity, minHeight: 150, idealHeight: 200, maxHeight: 250, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
            
        }.edgesIgnoringSafeArea(.vertical)
        
    }
}

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(titleText: "Title", descriptionText: "Description", disabled:false)
    }
}
