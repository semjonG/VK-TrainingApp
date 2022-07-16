//
//  UITableViewCell + Animation.swift
//  VK-TrainingApp
//
//  Created by mac on 16.07.2022.
//

import UIKit

extension UITableViewCell {
    func showAnimation()  {
        var transform = CGAffineTransform.identity
            transform = transform.scaledBy(x: 0.96, y: 0.96)
            UIView.animate(withDuration: 3.3,
                           delay: 0,
                           usingSpringWithDamping: 0.8,
                           initialSpringVelocity: 0,
                           options: [],
                           animations: {
              self.transform = transform
        }, completion: nil)
    }
}
