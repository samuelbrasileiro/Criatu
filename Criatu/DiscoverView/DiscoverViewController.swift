//
//  ViewController.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 12/11/20.
//

import UIKit
import SwiftUI

class DiscoverViewController: UIViewController {
        
    override func viewDidLoad() { 
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .systemBackground
        
        let discoverHost = UIHostingController(rootView: DiscoverView(bank: DiscoverBank.shared))
        self.addChild(discoverHost)
        discoverHost.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(discoverHost.view)
        
        let constraints = [
            discoverHost.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            discoverHost.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            discoverHost.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            discoverHost.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            discoverHost.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(constraints)
            
    }


}

