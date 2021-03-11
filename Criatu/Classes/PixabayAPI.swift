//
//  PixabayAPI.swift
//  Criatu
//
//  Created by Luis Pereira on 02/03/21.
//
import Foundation
import UIKit

class PixabayAPI {
    var baseURL = "https://pixabay.com/api/?key=20490794-452a82acc640fcfc4130d0bb8&per_page=3&lang=pt&"
    var imagesData: [Hit] = []
    
    func getData(tagsSearched:String,completionHandler: @escaping (Response) -> Void){
        let withoutAccentTag = tagsSearched.folding(options: .diacriticInsensitive, locale: .current)
        let formattedTag = withoutAccentTag.lowercased().replacingOccurrences(of: " ", with: "+")
        let url = URL(string: baseURL + "q=" + formattedTag)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let _ = error {
                print("Error accessing swapi.co: /(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: ??? ")
                return
            }
            
            if let data = data{
                do{
                    let searchResponse = try JSONDecoder().decode(Response.self, from: data)
                    self.imagesData = searchResponse.hits
                    
                    for image in self.imagesData {
                        image.tags += ", \(tagsSearched)"
                        
                        if let tags = self.getImageTags(id: image.id) {
                            image.tagsArray = tags
                        } else {
                            print("Something went wrong")
                        }
                    }
                    
                    completionHandler(searchResponse)
                }catch{
                    print(error.localizedDescription)
                }
                
            }
            
        })
        
        task.resume()
    }
    
    private func getImageTags(id:Int)->[String]?{
        let optionalImage: Hit? = imagesData.first(where: {
            $0.id == id
        })
        
        if let image = optionalImage{
            return image.tags.components(separatedBy: ", ")
        }
        
        return nil
    }
    
    
    func downloadImages() {
        for imageInfo in imagesData {
            let id = imageInfo.id
            let tags = self.getImageTags(id: imageInfo.id)!
            
            self.getImage(id: imageInfo.id, completionHandler: {image in
                let imageItem = ImageItem(imageID: id, tagsArray: tags, image: image)
                DispatchQueue.main.async {
                    DiscoverBank.shared.items.append(imageItem)
                }
            })
        }
    }
    
    func getImage(id:Int, completionHandler: @escaping (UIImage?)->Void){
        
        if imagesData.count == 0{
            completionHandler(nil)
            print("IMAGE COUNT EQUAL ZERO")
        }else{
            for image in imagesData{
                if image.id == id{
                    let url = URL(string: image.largeImageURL)
                    var request = URLRequest(url: url!)
                    request.httpMethod = "GET"
                    let task = URLSession.shared.dataTask(with: url!, completionHandler: {
                        data, response, error in
                        
                        if error != nil {
                            print("Error accessing swapi.co: /(error)")
                            completionHandler(nil)
                        }
                        
                        guard let httpResponse = response as? HTTPURLResponse,
                              (200...299).contains(httpResponse.statusCode) else {
                            print("Error with the response, unexpected status code: \(response)")
                            return
                        }
                        
                        if let data = data{
                            let image = UIImage(data: data)
                            completionHandler(image)
                        }else{
                            completionHandler(nil)
                        }
                    })
                 
                    task.resume()
                }
            }
        }
    }
}

class Response: Codable {
    let total, totalHits: Int
    let hits: [Hit]
    
    init(total: Int, totalHits: Int, hits: [Hit]) {
        self.total = total
        self.totalHits = totalHits
        self.hits = hits
    }
}
