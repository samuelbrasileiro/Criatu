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
        handler.testinho()
        print("escrevendo FireBase")
        // Do any additional setup after loading the view.
    }


}

