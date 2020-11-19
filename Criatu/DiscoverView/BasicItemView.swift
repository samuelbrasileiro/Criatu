//
//  BasicItemView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

struct BasicItemView: View {
    @ObservedObject var item: DiscoverItem
    var body: some View{
        if item.type == .music{
            MusicItemView(item: item as! MusicItem)
        }
        else if item.type == .image{
            ImageItemView(item: item as! ImageItem)
        }
    }
}

struct BasicItemView_Previews: PreviewProvider {
    static var previews: some View {
        BasicItemView(item: DiscoverBank().items[0])
    }
}
