//
//  TitleWardrobe.swift
//  Criatu
//
//  Created by Alanis Lima Santa Clara on 23/11/20.
//

import SwiftUI

struct TitleWardrobe: View {
    
    
 //   var categories: [String: [DiscoverBank]] {
//        //aqui o que penso eh que seria uma lista dos armarios disponiveis..
        
//        Dictionary(
//            grouping:
//        by: do { $0.category.rawValue }
//        )
//    }
//
    
    var body: some View {
        NavigationView{
            Text.navigationBarTitle(Text("Armários"))
            
            
        }
    }
    
    struct TitleWardrobe_Previews: PreviewProvider {
        static var previews: some View {
            TitleWardrobe()
        }
    }
}
