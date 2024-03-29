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
    func endInterestSelection()
    func isOnboarding() -> Bool
}
class OnboardingViewController: UIViewController, OnboardingDelegate {
    func isOnboarding() -> Bool {
        true
    }
    
    var onboardHost:UIHostingController<OnboardingPageView>?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .systemBackground
        
        onboardHost = UIHostingController(rootView: OnboardingPageView(delegate: self))
        self.addChild(onboardHost!)
        onboardHost!.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(onboardHost!.view)
        
        let constraints = [
            onboardHost!.view.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0),
            onboardHost!.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            onboardHost!.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            onboardHost!.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            onboardHost!.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
            
    }
    
    func endInterestSelection() {
        //change launch key
        UserDefaults.standard.set(true, forKey: Keys.kHasLaunchedOnce)
        UserDefaults.standard.synchronize()
        
        let vc = TabBarViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    
    func finishOnboarding() {
        let selectionHost = UIHostingController(rootView: DynamicCircleView(delegate: self))
        self.addChild(selectionHost)
        selectionHost.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.backgroundColor = .systemGray6
        self.view.addSubview(selectionHost.view)
        
        let constraints = [
            selectionHost.view.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 0),
            selectionHost.view.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            selectionHost.view.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            selectionHost.view.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            selectionHost.view.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}

