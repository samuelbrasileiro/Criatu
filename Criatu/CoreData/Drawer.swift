//
//  Drawer.swift
//  Criatu
//
//  Created by Beatrix Lee on 30/11/20.
//
//
import UIKit
import CoreData

class Drawer: NSManagedObject {
    @Published var allLooks: [DrawerLook] = []{
        willSet { self.objectWillChange.send() }
    }
    @Published var favoredLooks: [DrawerLook] = []{
        willSet { self.objectWillChange.send() }
    }
    
    func setDrawerView(){
        allLooks = []
        favoredLooks = []
        if let looksList = self.looks{
            for look in looksList{
                guard let look = look as? DrawerLook else {
                    return
                }
                self.allLooks.append(look)
                if look.isFavored{
                    self.favoredLooks.append(look)
                }
            }
        }
    }
}
