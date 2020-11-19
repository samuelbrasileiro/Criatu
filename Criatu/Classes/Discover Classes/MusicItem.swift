//
//  MusicItem.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

class MusicItem: DiscoverItem {
    @Published var title: String?{
        willSet { self.objectWillChange.send() }
    }
    @Published var artistName: String?{
        willSet { self.objectWillChange.send() }
    }
    
    var imageAlbumURL: String?
    
    @Published var imageAlbum: UIImage?{
        willSet { self.objectWillChange.send() }
    }
    
    override init(id: String, type: ItemType) {
        super.init(id: id, type: type)
        
        APMSong.fetch(songID: id){ result in
            if case .success(let songs) = result{
                if songs.data != nil{
                    
                    let song = songs.data![0].attributes!
                    print("amei " + song.name!)
                    self.title = song.name
                    self.artistName = song.artistName
                    self.url = song.previews?.first?.url
                    self.imageAlbumURL = song.artwork?.url
                    
                    if self.imageAlbumURL != nil{
                        self.getImage()
                    }
                    
                }
            }
            else if case .failure(let error) = result{
                print(error)
            }
        }
    }
    
    /// From image URL this function downloads and saves the
    /// image data in 'image' attribute
    func getImage(){

        let imageURL = imageAlbumURL?.replacingOccurrences(of: "{w}x{h}bb", with: "200x200")

        let request = URLRequest(url: URL(string: imageURL!)!)
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else {
                    return
                }
                
                if let image = UIImage(data: data){
                    self.imageAlbum = image
                }
            }
        }.resume()
    }
    
}
