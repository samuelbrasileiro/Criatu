//
//  PixabayAPI.swift
//  Criatu
//
//  Created by Luis Pereira on 02/03/21.
//

import Foundation
import UIKit

class PixabayAPI{
    
    var baseURL =  "https://pixabay.com/api/?key=20490794-452a82acc640fcfc4130d0bb8&per_page=3&lang=pt&"
    var imageInfoArr:[Hit] = []
    
    func GetData(tagsSearched:String,completionHandler: @escaping (Response) -> Void){
        
        let urlString = baseURL + "q=" + tagsSearched
        let url = URL(string: urlString)
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
            
            
            if let _ = error {
                print("Error accessing swapi.co: /(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(response)")
                return
            }
            
            if let data = data{
                
                do{
                    let searchResponse = try JSONDecoder().decode(Response.self, from: data)
                    print("CONVERSION SUCEDED")
                    self.imageInfoArr = searchResponse.hits
                    for imageInfo in self.imageInfoArr{
                        let tags = self.GetSplitedImageTags(id: imageInfo.id)!
                        let id = imageInfo.id
                        
                        self.GetImage(id: imageInfo.id, completionHandler: {image in
                            let imageItem = ImageItem(imageID: id, tagsArray: tags, image: image)
                            DispatchQueue.main.async {
                                DiscoverBank.shared.items.append(imageItem)
                            }
                            completionHandler(searchResponse)
                        })
                    }
                }catch{
                    print(error.localizedDescription)
                }
                
            }
            
        })
        
        task.resume()
    }
    
    func GetImageTags(id:Int) -> String?{
        var imageTags = String()
        for image in imageInfoArr{
            
            if image.id == id{
                imageTags = image.tags
                return imageTags
            }
        }
        return nil
    }
    
    func GetSplitedImageTags(id:Int)->[String]?{
        
        let imageTags = GetImageTags(id: id)
        if imageTags == nil{
            return nil
        }else{
            let tagsComponents = imageTags!.components(separatedBy: ", ")
            return tagsComponents
        }
    }
    
    func GetImage(id:Int, completionHandler: @escaping (UIImage?)->Void){
        
        if imageInfoArr.count == 0{
            completionHandler(nil)
            print("IMAGE COUNT EQUAL ZERO")
        }else{
            for image in imageInfoArr{
                if image.id == id{
                    let url = URL(string: image.largeImageURL)
                    var request = URLRequest(url: url!)
                    request.httpMethod = "GET"
                    let task = URLSession.shared.dataTask(with: url!, completionHandler: {
                        data, response, error in
                        
                        if let error = error {
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
                            print("IMAGE CONVERSION SUCEDED")
                            completionHandler(image)
                        }else{
                            print("IMAGE CONVERSION FAILED")
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

// MARK: - Hit
class Hit: Codable {
    let id: Int
    let pageURL: String
    let type: String
    let tags: String
    let previewURL: String
    let previewWidth, previewHeight: Int
    let webformatURL: String
    let webformatWidth, webformatHeight: Int
    let largeImageURL: String
    let imageWidth, imageHeight, imageSize, views: Int
    let downloads, favorites, likes, comments: Int
    let userID: Int
    let user: String
    let userImageURL: String
    
    enum CodingKeys: String, CodingKey {
        case id, pageURL, type, tags, previewURL, previewWidth, previewHeight, webformatURL, webformatWidth, webformatHeight, largeImageURL, imageWidth, imageHeight, imageSize, views, downloads, favorites, likes, comments
        case userID = "user_id"
        case user, userImageURL
    }
    
    init(id: Int, pageURL: String, type: String, tags: String, previewURL: String, previewWidth: Int, previewHeight: Int, webformatURL: String, webformatWidth: Int, webformatHeight: Int, largeImageURL: String, imageWidth: Int, imageHeight: Int, imageSize: Int, views: Int, downloads: Int, favorites: Int, likes: Int, comments: Int, userID: Int, user: String, userImageURL: String) {
        self.id = id
        self.pageURL = pageURL
        self.type = type
        self.tags = tags
        self.previewURL = previewURL
        self.previewWidth = previewWidth
        self.previewHeight = previewHeight
        self.webformatURL = webformatURL
        self.webformatWidth = webformatWidth
        self.webformatHeight = webformatHeight
        self.largeImageURL = largeImageURL
        self.imageWidth = imageWidth
        self.imageHeight = imageHeight
        self.imageSize = imageSize
        self.views = views
        self.downloads = downloads
        self.favorites = favorites
        self.likes = likes
        self.comments = comments
        self.userID = userID
        self.user = user
        self.userImageURL = userImageURL
    }
}
