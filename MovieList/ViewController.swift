//
//  ViewController.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 31.01.2024.
//

import UIKit

class ViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tabBar = TabBarViewController()
        addChild(tabBar)
        tabBar.view.frame = view.bounds
        view.addSubview(tabBar.view)
        tabBar.didMove(toParent: self)
        
    }
    
    


}

