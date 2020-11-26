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
    
    override init(id: String, type: ItemType) {
        super.init(id: id, type: type)
        fetchSongData()
    }
    
    func fetchSongData(){
        APMSong.fetch(songID: self.attributes.id){ result in
            if case .success(let songs) = result{
                if songs.data != nil{
                    
                    let song = songs.data![0].attributes!
                    print("This is: " + song.name!)
                    
                    self.title = song.name
                    self.artistName = song.artistName
                    self.url = song.previews?.first?.url

                }
            }
            else if case .failure(let error) = result{
                print(error)
            }
        }
    }
    
}
