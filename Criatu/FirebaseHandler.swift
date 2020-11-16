//
//  FirebaseHandler.swift
//  Criatu
//
//  Created by Marina Savluchinske on 16/11/20.
//

import Foundation
import FirebaseDatabase
class FirebaseHandler {
    func testinho() {
        let ref = Database.database().reference()
        ref.child("user").setValue("nina")
    }
}
