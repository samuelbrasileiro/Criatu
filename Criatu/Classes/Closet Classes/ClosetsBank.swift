//
//  ClosetsBank.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 25/11/20.
//

import Foundation
import CoreData

class ClosetsBank: ObservableObject{
    
    let content = AppDelegate.viewContext
    
    @Published var styles: [Style] = []
    
    init(){
        getStyles()
        
    }
    
    func getStyles() {
        
        let closetsRequest: NSFetchRequest<Closet> = Closet.fetchRequest()
        
        do {
            for closet in try content.fetch(closetsRequest) {
                self.styles.append(Style(closet: closet))
            }
        } catch {
            print(error)
        }
        
        
    }
    
}
