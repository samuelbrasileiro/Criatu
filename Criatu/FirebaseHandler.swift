//
//  FirebaseHandler.swift
//  Criatu
//
//  Created by Marina Savluchinske on 16/11/20.
//

import Foundation
import FirebaseDatabase

enum Collection: String {
    case interests = "interests/"
    case items = "items/"
    case closets = "closets/"
}

class FirebaseHandler {
    
    static var ref = Database.database().reference()
    
    
    init() {
        
        FirebaseHandler.readAllCollection(.interests, dataType: [Interest.Database].self){ result in
            if case .success(let interestsAttributes) = result{
                let interests = interestsAttributes.map{Interest(attributes: $0)}
                for interest in interests{
                    print(interest.attributes.itemsIDs)
                }
            }
        }
        
    }
    /// Adding an object to a collection
    /// - Parameters:
    ///   - collection: Collections are the categories in which the objects are stored
    ///   - value: The value of the objects
    class func writeToCollection<Type>(_ collection: Collection, value: Type)
    where Type: Codable{
        let childRef = ref.child(collection.rawValue).childByAutoId()
        
        do {
            var dictionary = try value.asDictionary()
            dictionary["id"] = childRef.key
            
            childRef.setValue(dictionary)
        }
        catch{
            print(error)
        }
    }
    
    
    /// Reading the objects written in the previous operation
    /// - Parameters:
    ///   - collection: Collections are the categories in which the objects are stored
    ///   - id: Is an identifier to the object. Each object has a unique id
    ///   - dataType: Identifying the type of the collection where the objects are stored
    ///   - completion: When the reading is over, this code is executed, it can be either successful or a failure
    class func readCollection<Type>(_ collection: Collection, id: String, dataType: Type.Type, completion: @escaping (Result<Type,Error>) -> Void)
    where Type: Codable{
        
        let pathReference = ref.child(collection.rawValue + id)
        
        pathReference.observeSingleEvent(of: .value, with: {(snapshot) in
            DispatchQueue.main.async {
                
                guard let data = snapshot.valueInExportFormat() else{
                    return
                }
                print(data)
                do{
                    
                    let decodedData = try Type(from: data)
                    completion(.success(decodedData))
                }
                catch{
                    completion(.failure(error))
                }
            }
            
        })
    }
    
    
    /// Reading all the collections at the same time
    /// - Parameters:
    ///   - collection: Collections are the categories in which the objects are stored
    ///   - dataType: Identifying the type of the collection where the objects are stored
    ///   - completion: When the reading is over, this code is executed, it can be either successful or a failure
    class func readAllCollection<Type>(_ collection: Collection, dataType: Type.Type, completion: @escaping (Result<Type,Error>) -> Void)
    where Type: Codable{
        
        let collectionRef = ref.child(collection.rawValue)
        
        collectionRef.observeSingleEvent(of: .value, with: {(snapshot) in
            
            DispatchQueue.main.async {
                
                guard let dict = snapshot.valueInExportFormat() as? [String: Any] else{
                    return
                }
                var data = dict.map{$0.value}
                data = data.map{ item -> Any? in
                    if let dict = item as? [String: Any]{
                        return dict.map{$0.value}
                    }
                    return item
                }
                do{
                    print(data)
                    let thing = try Type(from: data)
                    completion(.success(thing))
                }
                catch{
                    print(error)
                    completion(.failure(error))
                }
            }
            
        })
    }
    
}
extension Decodable {
    init(from data: Any) throws {
        let data = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
        
        self = try JSONDecoder().decode(Self.self, from: data)
    }
}

extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
