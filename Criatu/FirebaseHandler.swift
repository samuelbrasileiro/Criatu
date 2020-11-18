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
    let tagsPath = "tags/"
    let itensPath = "itens/"
    let closetPath = "closet/"
    var stringResponse:NSString? = NSString()
    var dictionaryResponse:NSDictionary? = NSDictionary()
    var numberResponse:NSNumber? = NSNumber()
    var arrayResponse:NSArray? = NSArray()
    var tagsCreated = true, itensCreated = true, closetCreated = true
    var dataReady = false
    
    
    init() {  
    }
    
    func WritingDataBase(path:String, value:Any) {
        
        ref.child(path).setValue(value)
    }
    
    func ReadDatabase<T>(path:String, dataType: T.Type){
        
        if dataReady{
            dataReady = false
        }
        
        let pathReference = ref.child(path)
        pathReference.observeSingleEvent(of: .value, with: {(snapshot) in
            
            let data = snapshot.value as? T
            print(data!)
            
            DispatchQueue.main.async {
                
                if T.self == NSNumber.self{
                    
                    self.numberResponse = (data as! NSNumber)
                    self.stringResponse = nil
                    self.dictionaryResponse = nil
                    self.arrayResponse = nil
                    
                }else if T.self == NSString.self{
                    
                    self.stringResponse = (data as! NSString)
                    self.numberResponse = nil
                    self.dictionaryResponse = nil
                    self.arrayResponse = nil
                    
                }else if T.self == NSDictionary.self{
                    
                    self.dictionaryResponse = (data as! NSDictionary)
                    self.numberResponse = nil
                    self.stringResponse = nil
                    self.arrayResponse = nil
                    
                }else{
                    
                    self.arrayResponse = (data as! NSArray)
                    self.numberResponse = nil
                    self.stringResponse = nil
                    self.dictionaryResponse = nil
                }
                
                self.dataReady = true
            }
            
        })
    }
    
    func isDataReadble (data:Any?) -> Bool{
        
        if data == nil{
            return false
        }else{
            return true
        }
    }
    
    func isDataReady() -> Bool{
        return dataReady
    }
    func UpdateOnceDatabase(path: String, value:Any, childID: String) {
       
        ref.child(path).updateChildValues([childID:value])
    }
    
    func RemoveOnceDatabase(path: String){
        ref.child(path).removeValue()
    }
    
}
