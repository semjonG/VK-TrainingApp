//
//  NewsCell.swift
//  VK-TrainingApp
//
//  Created by mac on 20.06.2022.
//

import UIKit

class NewsAuthorCell: UITableViewCell {
    
    static let identifire = "NewsAuthorCell"

    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var authorImageView: UIImageView = {
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
        contentView.addSubview(authorLabel)
        contentView.addSubview(authorImageView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            authorImageView.widthAnchor.constraint(equalToConstant: 50),
            authorImageView.heightAnchor.constraint(equalToConstant: 50),
            authorImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            authorImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            authorImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            authorLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            authorLabel.leftAnchor.constraint(equalTo: authorImageView.rightAnchor, constant: 20),
            authorLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
