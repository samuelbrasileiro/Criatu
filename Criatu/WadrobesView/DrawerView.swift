//
//  DrawerView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 03/12/20.
//

import SwiftUI


struct DrawerView: View {
    @ObservedObject var drawer: Drawer
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            
            Text("Meus favoritos")
                .padding([.top, .leading])
            
            ScrollView(.horizontal) {
                LazyHStack(spacing: 20) {
                    ForEach(0..<drawer.favoredLooks.count, id: \.self) { index in
                        
                        NavigationLink(destination: LookView(look: drawer.favoredLooks[index])) {
                            if let data = drawer.favoredLooks[index].image{
                                Image(uiImage: UIImage(data: data)!)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 100, height: 160)
                                    .clipped()
                                    
                                    .cornerRadius(20)
                            }
                        }
                    }
                }
                .padding(.leading)
                
            }
            .frame(height: 180)
            
            Text("Todos")
                .font(.largeTitle)
                .bold()
                .padding()
            LazyWaterfallGrid(data: drawer.allLooks, numberOfColumns: 2, horizontalSpacing: 8, verticalSpacing: 8, edgeInsets: EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)){ item in
                NavigationLink(destination: LookView(look: item)) {
                    if let data = item.image{
                        Image(uiImage: UIImage(data: data)!)
                            .resizable()
                            .scaledToFit()
                            .clipped()
                            .cornerRadius(20)
                    }
                }
            }
            
            .background(Color(.systemGray6))
            .cornerRadius(20)
            
        }
        .navigationTitle(drawer.name ?? "Gaveta")
        .onAppear {
            drawer.setDrawerView()
        }
    }
}
