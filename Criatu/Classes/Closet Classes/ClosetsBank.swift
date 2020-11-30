//
//  ClosetsBank.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 25/11/20.
//

import Foundation

class ClosetsBank: ObservableObject{
    
    @Published var styles: [Style] = []
    
    init(){
        getStyles()
        
    }
    
    func getStyles() {
        FirebaseHandler.readCollection(.closets, id: "-MNOV-lGoNFf7Oa7WW1n", dataType: Style.Database.self) { result in
            if case .success(let attributes) = result {
                self.styles.append(Style(attributes: attributes))
            }
        }
    }
    
}
