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
            if closets.count == 0{
                print("Fetching from firebase")
                //Luis TODO
                FirebaseHandler.readCollection(.closets, id: "-MNOV-lGoNFf7Oa7WW1n", dataType: Style.Database.self) { result in
                    if case .success(let attributes1) = result {
                        
                        FirebaseHandler.readCollection(.closets, id: "-MNP6eErV2Or6qZsipfO", dataType: Style.Database.self) { result in
                            if case .success(let attributes2) = result {
                                
                                self.styles = [Style(attributes: attributes1), Style(attributes: attributes2)]
                                
                            }
                        }
                        
                    }
                }
                
                
            }
            else{
                for closet in closets {
                    self.styles.append(Style(closet: closet))
                }
            }
        } catch {
            print(error)
        }
        
        
    }
    
}
