//
//  ViewController.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 12/11/20.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    let handler = FirebaseHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let mjks = "900032829"
        
        
        let artistsHost = UIHostingController(rootView: ImageItemView(imageItem: ImageItem(id: mjks, type: .image)))
        artistsHost.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(artistsHost.view)
        
        let constraints = [
            artistsHost.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            artistsHost.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            artistsHost.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            artistsHost.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            artistsHost.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
            
    }


}

