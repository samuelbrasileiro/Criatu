//
//  ViewController.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 12/11/20.
//

import UIKit
import SwiftUI

protocol OnboardingDelegate{
    func finishOnboarding()
}
class OnboardingViewController: UIViewController, OnboardingDelegate {
    
    func finishOnboarding() {
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    let handler = FirebaseHandler()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        
        let onboardHost = UIHostingController(rootView: OnboardingPageView(delegate: self))
        self.addChild(onboardHost)
        onboardHost.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(onboardHost.view)
        
        let constraints = [
            onboardHost.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            onboardHost.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            onboardHost.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            onboardHost.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            onboardHost.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
            
    }


}

