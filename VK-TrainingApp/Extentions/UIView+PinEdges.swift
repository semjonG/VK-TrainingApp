//
//  UIView+PinEdges.swift
//  VK-TrainingApp
//
//  Created by mac on 04.06.2022.
//

import UIKit

extension UIView {
    
    func pinEdgesToSuperView(_ distance: CGFloat = 0) {
        guard let superView = superview else { return }
        translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superView.topAnchor, constant: distance),
            leftAnchor.constraint(equalTo: superView.leftAnchor, constant: distance),
            bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: distance),
            rightAnchor.constraint(equalTo: superView.rightAnchor, constant: distance)
        ])
    }
}
