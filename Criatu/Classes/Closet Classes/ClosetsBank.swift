//
//  ClosetsBank.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 25/11/20.
//

import Foundation
import CoreData

class ClosetsBank: ObservableObject{
    
    let context = AppDelegate.viewContext
    
    @Published var styles: [Style] = []
    
    init(){
        getStyles()
    }
    
    func getStyles() {
        
        let closetsRequest: NSFetchRequest<Closet> = Closet.fetchRequest()
        
        do {
            let closets = try context.fetch(closetsRequest)
            self.styles = []
            if closets.contains(where: { closet in !styles.contains(where: {$0.attributes.id == closet.id})}){
                self.styles = []
            }
            
            for closet in closets {
                if !styles.contains(where: {$0.attributes.id == closet.id}){
                    self.styles.insert(Style(closet: closet), at: 0)
                }
            }
            
        } catch {
            print(error)
        }
        
        
    }
    
}
