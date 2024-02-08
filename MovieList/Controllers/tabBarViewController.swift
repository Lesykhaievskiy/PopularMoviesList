//
//  tabBarViewController.swift
//  MovieList
//
//  Created by Олексій Гаєвський on 31.01.2024.
//
import UIKit

class TabBarViewController: UITabBarController {

    let moviesListTitle = "Movies List"
    let favoritesTitle = "Favorites"

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white

        let listVC = MovieListViewController()
        let favoritesVC = FavoritesViewController()

        listVC.tabBarItem = UITabBarItem(title: moviesListTitle, image: UIImage(systemName: "house"), tag: 0)
        favoritesVC.tabBarItem = UITabBarItem(title: favoritesTitle, image: UIImage(systemName: "star"), tag: 1)

        setViewControllers([listVC, favoritesVC], animated: true)
    }
}
