//
//  MusicItem.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI
import AVKit
class MusicItem: DiscoverItem {

    @Published var title: String?{
        willSet { self.objectWillChange.send() }
    }
    @Published var artistName: String?{
        willSet { self.objectWillChange.send() }
    }
    
    var previewURL: String?
    
    override init(id: String, url: String, type: ItemType) {
        super.init(id: id, url: url, type: type)
        fetchSongData()
    }
    
    override init(attributes: DiscoverItem.Database){
        super.init(attributes: attributes)
        fetchSongData()
    }
    
    func fetchSongData(){
        APMSong.fetch(songID: self.attributes.url){ result in
            if case .success(let songs) = result{
                if songs.data != nil{
                    
                    let song = songs.data![0].attributes!
                    
                    self.title = song.name
                    self.artistName = song.artistName
                    self.previewURL = song.previews?.first?.url

                }
            }
            else if case .failure(let error) = result{
                print(error)
            }
        }
    }
    
}
