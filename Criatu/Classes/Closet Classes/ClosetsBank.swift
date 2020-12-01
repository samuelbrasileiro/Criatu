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
            if case .success(let attributes1) = result {

                FirebaseHandler.readCollection(.closets, id: "-MNP6eErV2Or6qZsipfO", dataType: Style.Database.self) { result in
                    if case .success(let attributes2) = result {
                        
                        FirebaseHandler.readCollection(.closets, id: "-MNP6eErV2Or6qZsipfO", dataType: Style.Database.self) { result in
                            if case .success(let attributes3) = result {
                                self.styles = [Style(attributes: attributes1), Style(attributes: attributes2), Style(attributes: attributes3)]
                            }
                        }
                        
                        
                        
                    }
                }
                
                
            }
        }



    }
    
}
