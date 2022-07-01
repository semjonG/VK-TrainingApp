//
//  NewsTextCell.swift
//  VK-TrainingApp
//
//  Created by mac on 01.07.2022.
//

import Foundation
import UIKit

class NewsTextCell: UITableViewCell {
    
    static let identifire = "NewsTextCell"

    lazy var newsTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func configure(_ friend: Friend) {
        
//        self.authorImageView.sd_setImage(with: URL(string: friend.photo50 ?? ""), completed: nil) // !!! изменить ссылки профиль / группа
//
//        self.authorImageView.contentMode = .scaleAspectFill
//
//        self.authorLabel.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")" // !!! изменить ссылки профиль / группа
    }
    
    // MARK: - Private
    
    private func setupViews() {
        // рутовая view у ячеек - contentView
        contentView.addSubview(newsTextLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            newsTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            newsTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            newsTextLabel.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            newsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
