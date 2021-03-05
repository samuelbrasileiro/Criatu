//
//  BasicItemView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

struct BasicItemView: View {
    @ObservedObject var item: DiscoverItem
    
    var delegate: DiscoverDelegate?
    
    var body: some View{
        if item.attributes.type == .music{
            MusicItemView(item: item as! MusicItem, delegate: delegate)
        }
        else if item.attributes.type == .image{
            ImageItemView(item: item as! ImageItem, delegate: delegate)
        }
    }
}

struct BasicItemView_Previews: PreviewProvider {
    static var previews: some View {
        BasicItemView(item: DiscoverBank.shared.items[0])
    }
}
