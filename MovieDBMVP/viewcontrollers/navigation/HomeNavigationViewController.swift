//
//  HomeNavigationViewController.swift
//  MovieDBMVP
//
//  Created by Khin Yadanar Thein on 08/08/2020.
//  Copyright © 2020 Khin Yadanar Thein. All rights reserved.
//

import UIKit

class HomeNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let mainVC = MainViewController(nibName: "MainViewController", bundle: nil)
        
        //let nav = UINavigationController()
        self.navigationBar.prefersLargeTitles = false
        self.navigationBar.isTranslucent = false
        self.navigationBar.backgroundColor = UIColor(named: "primary-color")
        self.navigationBar.barTintColor = UIColor(named: "primary-color")
        self.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        //nav.viewControllers = [mainVC]
        
        mainVC.navigationItem.title = "DISCOVERY"
        let menu = UIImage(systemName: "line.horizontal.3.decrease", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        let logo = UIBarButtonItem(image: menu, style: .plain, target: self, action: nil)
        
        let search = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))
        let searchBar = UIBarButtonItem(image: search, style: .plain, target: self, action: nil)
        
        mainVC.navigationItem.leftBarButtonItem = logo
        mainVC.navigationItem.rightBarButtonItem = searchBar
        self.navigationBar.tintColor = .white
        
        self.setViewControllers([
            mainVC
        ], animated: true)
        
    }
    

}
