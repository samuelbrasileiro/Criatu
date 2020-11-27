//
//  ViewController.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 12/11/20.
//

import UIKit
import SwiftUI

class WardrobesViewController: UIViewController {
        
    override func viewDidLoad() { 
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBackground
        
        let wardrobesView = UIHostingController(rootView: WardrobesView(bank: ClosetsBank()))
        self.addChild(wardrobesView)
        wardrobesView.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(wardrobesView.view)
        
        let constraints = [
            wardrobesView.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            wardrobesView.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            wardrobesView.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            wardrobesView.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            wardrobesView.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
            
    }


}

