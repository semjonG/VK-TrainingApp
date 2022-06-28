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
    private let newsVC = NewsVC()
    private let friendsTabBar = UITabBarItem()
    private let groupsTabBar = UITabBarItem()
    private let photosTabBar = UITabBarItem()
    private let newsTabBar = UITabBarItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        // clear color tabBar
//        tabBar.backgroundImage = getColoredImage(color: .clear, size: CGSize(width: view.frame.width, height: 100))
        
        friendsVC.tabBarItem.image = UIImage(systemName: "person")
        friendsVC.tabBarItem.title = "Friends"
        
        groupsVC.tabBarItem.image = UIImage(systemName: "person.3")
        groupsVC.tabBarItem.title = "Communities"
        
        photosVC.tabBarItem.image = UIImage(systemName: "photo")
        photosVC.tabBarItem.title = "Photos"
        
        newsVC.tabBarItem.image = UIImage(systemName: "newspaper")
        newsVC.tabBarItem.title = "News"
        
        let navigationFriendsVC = UINavigationController(rootViewController: friendsVC)
        let navigationGroupsVC = UINavigationController(rootViewController: groupsVC)
        let navigationPhotosVC = UINavigationController(rootViewController: photosVC)
        let navigationNewsVC = UINavigationController(rootViewController: newsVC)
        
        let controllers = [navigationFriendsVC, navigationGroupsVC, navigationPhotosVC, navigationNewsVC]
        self.viewControllers = controllers
        
        // rounded corners
        tabBar.layer.masksToBounds = true
        tabBar.layer.cornerRadius = 27
        tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
    }
    
    // animated tabBarItem
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
            guard let barItemView = item.value(forKey: "view") as? UIView else { return }

            let timeInterval: TimeInterval = 0.3
            let propertyAnimator = UIViewPropertyAnimator(duration: timeInterval, dampingRatio: 0.5) {
                barItemView.transform = CGAffineTransform.identity.scaledBy(x: 0.9, y: 0.9)
            }
            propertyAnimator.addAnimations({ barItemView.transform = .identity }, delayFactor: CGFloat(timeInterval))
            propertyAnimator.startAnimation()
        }
    
    // background image for tabBar
    func getColoredImage(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(origin: CGPoint(x: 0, y: 0), size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(rect)
        guard let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() else { return UIImage() }
        UIGraphicsEndImageContext()
        return image
    }
}


