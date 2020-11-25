//
//  MusicItemView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI
import AVKit

class Audio{
    static var player: AVAudioPlayer?
}

struct MusicItemView: View{
    
    @ObservedObject var item: MusicItem
    
    @State var stroke: Color = Color.clear
    @State var foregroundColor: Color = Color(.systemPurple)
    @State var backgroundColor: Color = Color(.systemGray5)
    
    @State var isPlaying: Bool = false
    
    var body: some View{
        if let name = item.title{
            Button(action: {
                item.isSelected = !item.isSelected
                changeColors()
                
            }){
                
                HStack{
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text(name)
                            .bold()
                            .lineLimit(2)
                        
                        Text(item.artistName!)
                            .font(.footnote)
                            .lineLimit(2)
                        
                    }
                    Spacer()
                    Button(action: {
                        
                        isPlaying = !isPlaying
                        if isPlaying{
                            let urlstring = item.url
                            let url = URL(string: urlstring!)
                            print("the url = \(url!)")
                            downloadFileFromURL(url: url!)
                        }
                        else{
                            Audio.player?.stop()
                        }
                        
                        
                    }){
                        if !isPlaying{
                            Image(systemName: "play.fill")
                        }
                        else{
                            Image(systemName: "pause.fill")
                        }
                    }
                    
                }
                .padding()
                .frame(minHeight: 0, maxHeight: 100, alignment: .center)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(10)
                
            }.onAppear(){
                changeColors()
            }
            
        }
        
    }
    func downloadFileFromURL(url:URL){
        URLSession.shared.downloadTask(with: url) { url, response, error in
            guard let url = url else {
                if let error = error {
                    print(error)
                }
                return
            }
            self.play(url: url)
            
        }.resume()
    }
    
    func play(url:URL) {
        print("playing \(url)")
                
        do {
            
            Audio.player = try AVAudioPlayer(contentsOf: url)
            Audio.player!.prepareToPlay()
            Audio.player!.volume = 1.0
            Audio.player!.play()
            
        } catch let error as NSError {
            //self.player = nil
            print(error.localizedDescription)
        } catch {
            print("AVAudioPlayer init failed")
        }
        
    }
    
    func changeColors(){
        if item.isSelected{
            stroke = Color(.systemPurple)
            foregroundColor = Color(.systemGray5)
            backgroundColor = Color(.systemPurple)
        }
        else{
            stroke = .clear
            foregroundColor = Color(.systemPurple)
            backgroundColor = Color(.systemGray5)
        }
    }
}

struct MusicItemView_Previews: PreviewProvider {
    static var previews: some View {
        MusicItemView(item: MusicItem(id: "1500952424", type: .music))
    }
}
