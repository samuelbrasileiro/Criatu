//
//  FirebaseHandler.swift
//  Criatu
//
//  Created by Marina Savluchinske on 16/11/20.
//

import Foundation
import FirebaseDatabase
class FirebaseHandler {
    let ref = Database.database().reference()
    func WritingDataBase(path:String, value:String) {
        ref.child(path).setValue(value)
    }
}
