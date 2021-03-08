//
//  NavigationMenuViewConroller.swift
//  Criatu
//
//  Created by Samuel Brasileiro on 25/11/20.
//

import UIKit
import SwiftUI
import FirebaseAnalytics
protocol SelectedViewDelegate{
    func changeSelectedIndex()
}
class TabViewItem{
    let name: String
    let viewController: UIViewController
    init(_ viewController: UIViewController, name: String){
        self.name = name
        self.viewController = viewController
    }
}
class SelectedView: ObservableObject{
    @Published var index: Int = 0
    
    var items: [TabViewItem] = []
    init(){
        items.append(TabViewItem(DiscoverViewController(), name: "Descubra"))
        items.append(TabViewItem(WardrobesViewController(), name: "Armário"))
        items.append(TabViewItem(UIHostingController(rootView: ProfileView()), name: "Perfil"))
    }
    
    func getViewControllers() -> [UIViewController]{
        return items.map{item in
            return item.viewController
        }
    }
}

class TabBarViewController: UITabBarController, SelectedViewDelegate {
    
    let handler = FirebaseHandler()
    
    func changeSelectedIndex() {
        let abas: [String] = ["Descubra", "Armário", "Perfil"]
        self.selectedIndex = selectedView.index
        Analytics.logEvent("Trocou_de_aba", parameters: ["Aba_Selecionada": abas[selectedView.index]])
    }
        
    var selectedView = SelectedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loadTabBar()
        
        self.viewControllers = selectedView.getViewControllers()
    }
    
    func loadTabBar() {
        let tabBarHost = UIHostingController(rootView: MainTabView(selectedView: selectedView, delegate: self))
        tabBarHost.view.translatesAutoresizingMaskIntoConstraints = false
        
        self.addChild(tabBarHost)
        self.view.addSubview(tabBarHost.view)
        
        let constraints = [
            tabBarHost.view.topAnchor.constraint(equalTo: self.tabBar.safeAreaLayoutGuide.topAnchor, constant: -20),
            tabBarHost.view.centerXAnchor.constraint(equalTo: self.tabBar.safeAreaLayoutGuide.centerXAnchor, constant: 0),
            tabBarHost.view.leadingAnchor.constraint(equalTo: self.tabBar.safeAreaLayoutGuide.leadingAnchor, constant: 0),
            tabBarHost.view.trailingAnchor.constraint(equalTo: self.tabBar.safeAreaLayoutGuide.trailingAnchor, constant: 0),
            tabBarHost.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
}
