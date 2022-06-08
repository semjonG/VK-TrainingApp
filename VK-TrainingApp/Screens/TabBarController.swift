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
    private let friendsTabBar = UITabBarItem()
    private let groupsTabBar = UITabBarItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        friendsVC.tabBarItem.image = UIImage(systemName: "person")
        friendsVC.tabBarItem.title = "Friends"
        
        groupsVC.tabBarItem.image = UIImage(systemName: "person.3")
        groupsVC.tabBarItem.title = "Communities"
        let navigationFriendsVC = UINavigationController(rootViewController: friendsVC)
        let navigationGroupsVC = UINavigationController(rootViewController: groupsVC)
        
        let controllers = [navigationFriendsVC, navigationGroupsVC]
        self.viewControllers = controllers
    }
}


