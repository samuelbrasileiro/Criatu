//
//  Song.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 17/11/20.
//

import Foundation
import StoreKit

var musicAcessTokenKey = "MIGTAgEAMBMGByqGSM49AgEGCCqGSM49AwEHBHkwdwIBAQQgbOMaeCKD0b+JlbCzkE0IKiY+Vr7sGZt2XoeGiU22qOmgCgYIKoZIzj0DAQehRANCAARsZco046SVjL2SXqEoeQHen/qrXZfrZH1fOt6tKFVfCX0zX6p4P/+hvwBRhMe0nC+xqi412/VM3f9r8QvZGoJv"


// MARK: - Song
class Song: Codable {
    let data: [SongDatum]?

    init(data: [SongDatum]?) {
        self.data = data

    }
    
    class func fetch(songID: String, completion: @escaping (Result<Song,Error>) -> Void){
        
        let url = URL(string: "https://api.music.apple.com/v1/catalog/us/songs/" + songID)!
        var request = URLRequest(url: url)
        request.setValue("Bearer " + musicAcessTokenKey, forHTTPHeaderField: "Authorization")
        
        SKCloudServiceController().requestUserToken(forDeveloperToken: musicAcessTokenKey){ (result, error) in
            print(error!)
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            do {
                print(response.debugDescription)
                print(data)
                let song = try JSONDecoder().decode(Song.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(song))
                }
                
                
            } catch let error {
                print(error)
                completion(.failure(error))
            }
        }.resume()
    }

    
}

// MARK: - SongDatum
class SongDatum: Codable {
    let attributes: Attributes?
    let href, id: String?
    let relationships: Relationships?
    let type: String?

    init(attributes: Attributes?, href: String?, id: String?, relationships: Relationships?, type: String?) {
        self.attributes = attributes
        self.href = href
        self.id = id
        self.relationships = relationships
        self.type = type
    }
}

// MARK: - Attributes
class Attributes: Codable {
    let albumName, artistName: String?
    let artwork: Artwork?
    let composerName: String?
    let discNumber, durationInMillis: Int?
    let genreNames: [String]?
    let isrc, name: String?
    let playParams: PlayParams?
    let previews: [Preview]?
    let releaseDate: String?
    let trackNumber: Int?
    let url: String?

    init(albumName: String?, artistName: String?, artwork: Artwork?, composerName: String?, discNumber: Int?, durationInMillis: Int?, genreNames: [String]?, isrc: String?, name: String?, playParams: PlayParams?, previews: [Preview]?, releaseDate: String?, trackNumber: Int?, url: String?) {
        self.albumName = albumName
        self.artistName = artistName
        self.artwork = artwork
        self.composerName = composerName
        self.discNumber = discNumber
        self.durationInMillis = durationInMillis
        self.genreNames = genreNames
        self.isrc = isrc
        self.name = name
        self.playParams = playParams
        self.previews = previews
        self.releaseDate = releaseDate
        self.trackNumber = trackNumber
        self.url = url
    }
}

// MARK: - Artwork
class Artwork: Codable {
    let bgColor: String?
    let height: Int?
    let textColor1, textColor2, textColor3, textColor4: String?
    let url: String?
    let width: Int?

    init(bgColor: String?, height: Int?, textColor1: String?, textColor2: String?, textColor3: String?, textColor4: String?, url: String?, width: Int?) {
        self.bgColor = bgColor
        self.height = height
        self.textColor1 = textColor1
        self.textColor2 = textColor2
        self.textColor3 = textColor3
        self.textColor4 = textColor4
        self.url = url
        self.width = width
    }
}

// MARK: - PlayParams
class PlayParams: Codable {
    let id, kind: String?

    init(id: String?, kind: String?) {
        self.id = id
        self.kind = kind
    }
}

// MARK: - Preview
class Preview: Codable {
    let url: String?

    init(url: String?) {
        self.url = url
    }
}

// MARK: - Relationships
class Relationships: Codable {
    let albums, artists: Albums?

    init(albums: Albums?, artists: Albums?) {
        self.albums = albums
        self.artists = artists
    }
}

// MARK: - Albums
class Albums: Codable {
    let data: [AlbumsDatum]?
    let href: String?

    init(data: [AlbumsDatum]?, href: String?) {
        self.data = data
        self.href = href
    }
}

// MARK: - AlbumsDatum
class AlbumsDatum: Codable {
    let href, id, type: String?

    init(href: String?, id: String?, type: String?) {
        self.href = href
        self.id = id
        self.type = type
    }
}
