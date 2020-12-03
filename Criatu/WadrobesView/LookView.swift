//
//  LookView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 03/12/20.
//

import SwiftUI

struct LookView: View {
    @ObservedObject var look: DrawerLook
    
    let screen = UIScreen.main.bounds
    var body: some View {
        ZStack(alignment: .topTrailing) {
            if let data = look.image{
            Image(uiImage: UIImage(data: data)!)
                .resizable()
                .scaledToFill()
                .frame(width: screen.width - 100, height: screen.height - 350, alignment: .center)
                
                .clipped()
                .cornerRadius(20)
                
                .padding(.horizontal)
                .padding(.top)
            }
            
                
                Button(action: {
                    let context = AppDelegate.viewContext
                    look.isFavored.toggle()
                    //look.objectWillChange.send()
                    do{
                        try context.save()
                    }catch{
                        print(error)
                    }
                }) {
                    Image(systemName: "star.circle.fill")
                        .resizable()
                        .frame(width: 70, height: 70)
                        .foregroundColor(self.look.isFavored ? Color(.systemPurple) : Color(.systemGray4))
                        .background(Circle().fill(Color(.systemGray6)))
                    
                    
                }
        }
        .padding(.bottom, 40)
        
    }
}


