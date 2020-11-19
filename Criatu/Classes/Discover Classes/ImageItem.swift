//
//  ImageItem.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI

class ImageItem: DiscoverItem {
    
    @Published var image: UIImage?{
        willSet { self.objectWillChange.send() }
    }
    
    override init(id: String, type: ItemType) {
        super.init(id: id, type: type)
        //apagar//soprateste//usarfirebaseapartirdoidprapegarURL
        url = "https://is3-ssl.mzstatic.com/image/thumb/Music113/v4/fb/97/a0/fb97a00f-282c-5a31-eb62-80f3d69410b6/20UMGIM15390.rgb.jpg/200x200.jpeg"
        
        getImage()
    }
    
    /// From image URL this function downloads and saves the
    /// image data in 'image' attribute
    func getImage(){
        let request = URLRequest(url: URL(string: url!)!)
        URLSession.shared.dataTask(with: request) {(data, response, error) in
            DispatchQueue.main.async {
                guard let data = data else{
                    return
                }
                if let image = UIImage(data: data){
                    self.image = image
                }
            }
        } .resume()
    }
}
