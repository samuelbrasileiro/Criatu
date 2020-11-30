//
//  FirebaseHandler.swift
//  Criatu
//
//  Created by Marina Savluchinske on 16/11/20.
//

import Foundation
import FirebaseDatabase
import FirebaseStorage

enum Collection: String {
    case interests = "interests/"
    case items = "items/"
    case closets = "closets/"
}

class FirebaseHandler {
    
    static var ref = Database.database().reference()
    
    static var storage = Storage.storage().reference()
    init() {
        
        let names = ["granola_01","granola_02", "granola_03", "granola_04", "granola_05","granola_06", "granola_07", "granola_08", "granola_09","granola_10"]
                var count = 0
                var urls: [String] = []
                for name in names{
                    FirebaseHandler.storage.child("looks").child(name + ".jpg").downloadURL{ url, error in
                        if let url = url{
                            urls.append(url.absoluteString)
                        }
                        count += 1
                        if count == names.count{
                            
                            count = 0

                            var style = Style.Database(id: "", name: "Granola", description: "Um armário para aqueles que amam estar em contato com a natureza e, quando puder, tenha a certeza que vai estar.  Sempre com a cabeça nas nuvens, os granolas visam um visual mais imaginativo e natural, normalmente ecológico e vegano.", imageURL: "https://is4-ssl.mzstatic.com/image/thumb/Music1/v4/4c/11/c3/4c11c35e-98ff-c7c5-59c3-7ed4fa50db2a/075679921338.jpg/400x400.jpeg", looksURL: urls)
                            print("foi")
                            
                            FirebaseHandler.writeToCollection(.closets, value: style)
                            

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
    
    class func getItemImage(from id: String, completion: @escaping (Result<UIImage, Error>) -> Void){
        let ref = storage.child("images")

        let imageRef = ref.child(id)
        
        imageRef.getData(maxSize: 1 * 2048 * 2048){ data, error in
            
            if let error = error{
                print(error.localizedDescription)
                completion(.failure(error))
            }
            if let data = data{
                if let image = UIImage(data: data){
                    completion(.success(image))
                }
            }
        }
    }
    
    
    class func addItemsIDsToInterests(interestID: String, itemsIDs: [String]?){
        let childRef = ref.child(Collection.interests.rawValue).child(interestID).child("items_ids")
        
        childRef.setValue(itemsIDs)

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
                
                guard var data = snapshot.valueInExportFormat() as? [String: Any] else{
                    return
                }
                
                //Convert Dictionary Items to Array
                var dict = data
                for key in data.keys{
                    if let data = data[key] as? [String: Any]{
                        dict[key] = data.map{$0.value}
                        
                    }
                }
                data = dict
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
                
                //Convert Dictionary to Array
                var data = dict.map{$0.value}
                data = data.map{ item -> Any? in
                    if var dict = item as? [String: Any]{
                        for key in dict.keys{
                            if let data = dict[key] as? [String: Any]{
                                dict[key] = data.map{$0.value}
                                return dict
                            }
                        }
                    }
                    return item
                }
                
                do{
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
