//
//  NewsImageView.swift
//  VK-TrainingApp
//
//  Created by mac on 01.07.2022.
//

import Foundation
import UIKit

class NewsPhotoCell: UITableViewCell {
    
    static let identifire = "NewsPhotoCell"
    
    lazy var newsPhotoView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        return imageView
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

        contentView.addSubview(newsPhotoView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            newsPhotoView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1),
            newsPhotoView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 1), // !!! изменить соотношение сторон
            newsPhotoView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            newsPhotoView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            newsPhotoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
            
        ])
    }
}
