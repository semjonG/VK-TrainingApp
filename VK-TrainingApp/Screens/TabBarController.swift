//
//  TabBarController.swift
//  VK-TrainingApp
//
//  Created by mac on 08.06.2022.
//

import UIKit

final class TabBarController: UITabBarController {
    
    private let friendsVC = FriendsVC()
    private let groupsVC = GroupsVC()
    private let photosVC = PhotosVC()
    private let friendsTabBar = UITabBarItem()
    private let groupsTabBar = UITabBarItem()
    private let photosTabBar = UITabBarItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsVC.tabBarItem.image = UIImage(systemName: "person")
        friendsVC.tabBarItem.title = "Friends"
        
        groupsVC.tabBarItem.image = UIImage(systemName: "person.3")
        groupsVC.tabBarItem.title = "Communities"
        
        photosVC.tabBarItem.image = UIImage(systemName: "photo")
        photosVC.tabBarItem.title = "Photos"
        
        let navigationFriendsVC = UINavigationController(rootViewController: friendsVC)
        let navigationGroupsVC = UINavigationController(rootViewController: groupsVC)
        let navigationPhotosVC = UINavigationController(rootViewController: photosVC)
        
        let controllers = [navigationFriendsVC, navigationGroupsVC, navigationPhotosVC]
        self.viewControllers = controllers
    }
}


