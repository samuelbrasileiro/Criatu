//
//  ViewController.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 12/11/20.
//

import UIKit

class ViewController: UIViewController {
    let handler = FirebaseHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mjks = "900032829"
        
        
        Song.fetch(songID: mjks){result in
            if case .success(let song) = result {
                print(song.data![0].attributes!.artistName!)
            }
            else if case .failure(let error) = result{
                print(error.localizedDescription)
            }
            
        }
    }


}

