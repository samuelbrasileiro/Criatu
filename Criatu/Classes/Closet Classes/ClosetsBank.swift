//
//  ClosetsBank.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 25/11/20.
//

import Foundation

class ClosetsBank: ObservableObject{
    var styles: [Style] = []
    
    init(){
        getStyles()
        
    }
    
    func getStyles() {
        styles.append(Style(id: "sdkcdsvsdv", name: "Granola", description: "Um armário para aqueles que amam estar em contato com a natureza e, quando puder, tenha a certeza que vai estar.  Sempre com a cabeça nas nuvens, os granolas visam um visual mais imaginativo e natural, normalmente ecológico e vegano.", imageURL: "https://is4-ssl.mzstatic.com/image/thumb/Music1/v4/4c/11/c3/4c11c35e-98ff-c7c5-59c3-7ed4fa50db2a/075679921338.jpg/400x400.jpeg"))
        
        styles.append(Style(id: "abranskepa", name: "Luis", description: "Quem não tem pó cheira loló", imageURL: "https://is5-ssl.mzstatic.com/image/thumb/Music114/v4/fb/3e/c9/fb3ec9f8-2c09-1059-9da0-c6945132d9f0/0.jpg/400x400.jpeg"))
        styles.append(Style(id: "godifjdckz", name: "Influencer", description: "Cansado de ser uma pessoa comum? Os influencers sempre estão com esse sentimento. Sempre gravando tiktoks, procuram as roupas mais trending, para sempre estarem a par do fashion.", imageURL: "https://is4-ssl.mzstatic.com/image/thumb/Music1/v4/4c/11/c3/4c11c35e-98ff-c7c5-59c3-7ed4fa50db2a/075679921338.jpg/400x400.jpeg"))
        styles.append(Style(id: "aklslasaana", name: "Alanis", description: "Eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl", imageURL: "https://is3-ssl.mzstatic.com/image/thumb/Music113/v4/fb/97/a0/fb97a00f-282c-5a31-eb62-80f3d69410b6/20UMGIM15390.rgb.jpg/400x400.jpeg"))
    }
    
}
