//
//  MusicItemView.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 19/11/20.
//

import SwiftUI
import AVKit

class AudioPreview{
    static var shared = AudioPreview()
    
    var player: AVAudioPlayer?
    var songID: String
    init(){
        songID = ""
    }
}

struct MusicItemView: View{
    
    @ObservedObject var item: MusicItem
    
    @State var stroke: Color = Color.clear
    @State var foregroundColor: Color = Color(.systemPurple)
    @State var backgroundColor: Color = Color(.systemGray5)
    
    @State var isPlaying: Bool = false
    
    let preview = AudioPreview.shared
    
    let isPlayingPub = NotificationCenter.default
                .publisher(for: NSNotification.Name("isPlayingChangedInAMusicView"))
    
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

                        if !isPlaying{
                            //se o botão estiver no estado não tocando antes
                            if let urlstring = item.previewURL{
                                let url = URL(string: urlstring)
                                downloadFileFromURL(url: url!)
                            }
                        }
                        else{
                            preview.player?.stop()
                        }
                        
                        NotificationCenter.default.post(name: Notification.Name("isPlayingChangedInAMusicView"), object: self)
                        
                    }){
                        if !isPlaying{
                            Image(systemName: "play.fill")
                        }
                        else{
                            Image(systemName: "pause.fill")
                        }
                        
                    }.onReceive(isPlayingPub, perform: { notification in
                        if let object = notification.object as? MusicItemView{
                            
                            if self.item.attributes.id == object.item.attributes.id{
                                
                                isPlaying = !isPlaying
                            }
                            else{
                                isPlaying = false
                            }
                        }
                    })
                    
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
            
            preview.player = try AVAudioPlayer(contentsOf: url)
            preview.player!.prepareToPlay()
            preview.player!.volume = 1.0
            preview.player!.play()
            
        } catch let error as NSError {
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
        MusicItemView(item: MusicItem(id: "1500952424", url: "1500952424", type: .music))
    }
}
