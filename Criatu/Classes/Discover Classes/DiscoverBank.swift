//
//  DiscoverBank.swift
//  Criatu
//
//  Created by Beatrix Lee on 18/11/20.
//

import UIKit
import SwiftUI
import CoreData

protocol DiscoverDelegate{
    func didSelectInterest(_ interest: Interest)
    func didDisselectInterest(_ interest: Interest)
    func uploadView()
}


class DiscoverBank: ObservableObject, Identifiable, DiscoverDelegate {
    
    static let shared = DiscoverBank()
    
    @Published var items: [DiscoverItem] = []
    @Published var interests: [Interest] = []
    @Published var searchText: String = ""
    @Published var isSearching: Bool = false
    @Published var allInterests: [Interest] = []
    @Published var discoveredStyle: Style?
    @Published var didDiscoverNewStyle: Bool = false
    @Published var didNotDiscoverStyle: Bool = false
    @Published var isDiscovering: Bool = false
    
    var minimumSelectedItens: Int = 0
    
    init() {
        self.clear()
        self.addInterests()
    }
    
    /// This function clears all items in the array 'items'
    func clear(){
        items.removeAll()
        interests.removeAll()
        searchText = ""
        isSearching = false
        allInterests.removeAll()
        discoveredStyle = nil
        isDiscovering = false
        didDiscoverNewStyle = false
        didNotDiscoverStyle = false
    }
    
    func addInterests(){
        if var interests = Interest.restore(){
            interests.shuffle()
            let count = interests.count < 3 ? interests.count : 3
            for index in 0..<count{
                interests[index].isSelected = true
                self.didSelectInterest(interests[index])
            }
            self.interests = interests

        }
    }
    
    func discoverStyle(){
        self.isDiscovering = true
        let selectedItems = items.filter{ $0.isSelected }
        let userSet: TagsSet = TagsSet<String>()
        var similarityResults: [String : Float] = [:]
        
        let closets: [ClosetInterface] = [
            ClosetInterface(id: "-MNOV-lGoNFf7Oa7WW1n", tags: TagsSet(["café", "bebida", "quente", "cappuccino", "pipoca", "entretenimento", "cinema", "balde", "doces", "gummies", "balas de goma","doçura", "amsterdam", "canal", "cidade", "red", "luzes", "distrito", "montanha", "flores", "paisagem", "natureza", "calçadão", "pier", "mar", "audiência", "concerto", "guitarra", "jazz", "saxofone", "dj turntable", "eletrônica","gato", "animal de estimação", "lambendo", "felino", "arara", "papagaio", "arara amarela", "colorido", "leão", "animal", "cabeça","juba","biblioteca","arquitetura","livros","design moderno","arquitetura moderna","walt disney center","sala de concertos","design","castelo", "belvedere vir","palácio", "baroque","fones", "fone", "fones de couvido", "flores", "buque de flores", "perfume", "cheiroso", "fragrância"])), //Criativo
            
            
            ClosetInterface(id: "-MNP6eErV2Or6qZsipfO", tags: TagsSet(["framboesa", "baga", "verão","palácio", "londres", "parlamento", "inglaterra", "saxofone", "músicas", "concerto", "jazz","cisne", "par", "amor", "cisnes","baroque", "castelo", "belvedere vir", "palácio","garrafa", "perfume","rosas","fragrância"])),//Contemporâneo
            
            
            ClosetInterface(id: "-MNYbEkkQHkxRK0YMVJo", tags: TagsSet(["whey","burger","hambúrguer","carne","hambúrguer","pizza","fast food","churrasco","dieta","grelhados","pier","mar","praia","litoral","Horizonte","montanha","flores","verde","palácio","viagens","guitar","rock","metal","guitarra","dj","eletrônica","balada","vida noturna","festa","dançar","música clássica","concerto","instrumentaos musicais","orquestra","gato","animal de estimação","lambendo","felino","vida selvagem","raposa","natureza","leão","selvagem","selva","juba","biblioteca","arquitetura","livros","design moderno","arquitetura moderna","monumento","construção","escultura","pilares","aço","pós moderno","concreto","design","fones","fones de ouvido","luneta","telescópio","paisagem","férias","observação","descoberta","diário","querido diário","sonhos","leitura"])),//Esportivo
            
            
            ClosetInterface(id: "-MNYbNl7yyEmDZ9hdZPK", tags: TagsSet(["pizza", "fast food", "comida italiana", "framboesa", "red", "verão", "taça", "apetitoso", "maduro", "bolinhos", "ásia", "aperitivo", "tempero", "comida asiática", "pier", "mar", "praia", "litoral", "amsterdam", "canal", "cidade", "natureza", "praia", "itália", "luzes da cidade", "audiência", "concerto", "celebração", "banda", "luzes", "cantor", "audiência", "MPB", "mpb", "Música popular brasileira", "vida selvagem", "raposa", "natureza","leão","selvagem","selva","juba","pássaro","asas","plumagem","aves","penas","escultura","pilares","aço","pós moderno","concreto","design", "perfume","cheiroso","fragrância"])),//Moderno
            
            ClosetInterface(id: "-MNYbT6ljnhwJcLHv2Xn", tags: TagsSet(["pizza","alimentos","refeição","comida italiana","burguer","fast food","hambúrguer","cheeseburguer","café","bebida","quente","cappuccini","calçadão","pier","mar","praia","montanha","flores","paisagem","natureza","amsterdam","canal","distrito","red","luz","rock","concerto","guitarra","guitarrista","saxofone","músicas","concerto","jazz","rap","microfone","músico","raposa","fox","animal","vermelho","leão","juba","cabeça","pássaro","bagas","asas","neoclássico","arquitetura","administração","capital","moderno","biblioteca","design de interiores","baroque","castelo","belvedere vir","palácio","fone de ouvido","músicas","ouvir","estilo de vida","perfume","garrafa","rosas","fragrância","xícara","inverno","caneca"])),//Tradicional
        ]
        
        for item in selectedItems {
            userSet.data.append(contentsOf: item.tagsArray.map{ $0 })
        }
        
        for closet in closets {
            similarityResults[closet.id] = userSet.jaccardSimilarity(to: closet.tags)
        }
        
        let sortedDictionary = similarityResults.sorted {
            (first: (key: String, value: Float), second: (key: String, value: Float)) -> Bool in
            return first.value > second.value
        }
        
        Timer.scheduledTimer(withTimeInterval: 2, repeats: false){ _ in
            self.isDiscovering = false
            
            FirebaseHandler.readCollection(.closets, id: sortedDictionary[0].key, dataType: Style.Database.self) { result in
                if case .success(let attributes) = result {
                    self.discoveredStyle = Style(attributes: attributes)
                    self.didDiscoverNewStyle = true
                } else {
                    self.didNotDiscoverStyle = true
                }
            }
            
        }
    }
    
    func clearAllInterests(){
        self.allInterests.removeAll()
    }
    
    func addInterestToTop(interest: Interest){
        if self.interests.filter({ $0.attributes.id == interest.attributes.id}).count == 0{
            self.interests.insert(interest, at: 0)
        }
    }
    
    func didSelectInterest(_ interest: Interest){
        
        let api = PixabayAPI()
        api.getData(tagsSearched: interest.attributes.name, completionHandler: {_ in
            api.downloadImages()
        })
        
        
    }
    func didDisselectInterest(_ interest: Interest){
        
        //New PixaBay itens filter
        items = items.filter { item in
            return !item.tagsArray.contains(interest.attributes.name.lowercased())
        }
        
    }
    
    func uploadView() {
        self.objectWillChange.send()
    }
    
    
}
