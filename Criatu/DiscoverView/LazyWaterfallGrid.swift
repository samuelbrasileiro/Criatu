//
//  LazyWaterfallGrid.swift
//  MeusTopArtistas
//
//  Created by Samuel Brasileiro on 18/11/20.
//

import SwiftUI

struct LazyWaterfallGrid<Elements, Content>: View
    where Elements: RandomAccessCollection, Content: View {
    
    var data: Elements
    
    var numberOfColumns: Int
    var horizontalSpacing: CGFloat = 10
    var verticalSpacing: CGFloat = 10
    var edgeInsets: EdgeInsets = EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
    var content: (Elements.Element) -> Content
    
    var body: some View{
        
        ScrollView {
            HStack(alignment: .top, spacing: verticalSpacing){
                ForEach(0..<self.numberOfColumns,id: \.self){ column in
                    LazyVStack(spacing: horizontalSpacing){
                        ForEach((0..<self.data.count).filter{$0%self.numberOfColumns==column}, id: \.self) { index in
                            self.content(self.data[index as! Elements.Index])
                        }
                        .animation(.default)
                    }
                }
            }
            .padding(edgeInsets)
        }
        
    }
}
