//
//  FriendCell.swift
//  VK-TrainingApp
//
//  Created by mac on 24.05.2022.
//

import UIKit

class FriendCell: UITableViewCell {
    
    static let identifier = "FriendCell" // зачем? если мы прописали идентификатор в FriendsViewController как "cell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0 // зачем?
        label.lineBreakMode = .byWordWrapping // ??
        return label
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 25
        imageView.clipsToBounds = true // чтобы вписать вью в сабвью?
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    // запасной инициализатор
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public
    func configure(_ friend: Friend) {
        self.photoImageView.sd_setImage(with: URL(string: friend.photo100), completed: nil)
        
        self.photoImageView.contentMode = .scaleAspectFill
        
        self.nameLabel.text = "\(friend.firstName) \(friend.lastName) \(friend.city?.title ?? "")"
    }
    
    
    
    
    
    
    
    
    
    
    // MARK: - Private
    
    private func setupViews() {
        // рутовая view у ячеек - contentView
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        // нельзя устанавливать констрейнты, пока на вью не добавлен элемент
        NSLayoutConstraint.activate([
            
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
