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
        styles.append(Style(id: "sdkcdsvsdv", name: "Granola", description: "Um armário para aqueles que amam estar em contato com a natureza e, quando puder, tenha a certeza que vai estar.  Sempre com a cabeça nas nuvens, os granolas visam um visual mais imaginativo e natural, normalmente ecológico e vegano.", imageURL: "https://is3-ssl.mzstatic.com/image/thumb/Music113/v4/fb/97/a0/fb97a00f-282c-5a31-eb62-80f3d69410b6/20UMGIM15390.rgb.jpg/200x200.jpeg"))
        
        styles.append(Style(id: "abranskepa", name: "Georgia", description: "Quem não tem pó cheira loló", imageURL: "https://is3-ssl.mzstatic.com/image/thumb/Music113/v4/fb/97/a0/fb97a00f-282c-5a31-eb62-80f3d69410b6/20UMGIM15390.rgb.jpg/200x200.jpeg"))
        
        styles.append(Style(id: "aklslasaana", name: "Samuel", description: "Eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl eu sou uma egirl", imageURL: "https://is3-ssl.mzstatic.com/image/thumb/Music113/v4/fb/97/a0/fb97a00f-282c-5a31-eb62-80f3d69410b6/20UMGIM15390.rgb.jpg/200x200.jpeg"))
    }
    
}
