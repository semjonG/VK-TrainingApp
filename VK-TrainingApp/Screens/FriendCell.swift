//
//  FriendCell.swift
//  VK-TrainingApp
//
//  Created by mac on 24.05.2022.
//

import UIKit
import SDWebImage

class FriendCell: UITableViewCell {
    
    static let identifier = "FriendCell" // зачем? если мы прописали идентификатор в FriendsViewController как "cell"
        
    lazy var backView: UIView = {
        let view = UIView(frame: CGRect(x: 10, y: 6, width: self.frame.width + 50, height: 130))
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
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
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true // чтобы вписать вью в сабвью?
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
    

    // MARK: - shadow of the cell
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 25
        backView.clipsToBounds = true
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = .zero
    }
    
    // MARK: - Public
    func configure(_ friend: Friend) {
        
        self.photoImageView.sd_setImage(with: URL(string: friend.photo100 ?? ""), completed: nil)

        self.photoImageView.contentMode = .scaleAspectFill

        self.nameLabel.text = "\(friend.firstName ?? "") \(friend.lastName ?? "")  \(friend.city?.title ?? "")"
    }
    
    // MARK: - Private
    
    private func setupViews() {
        // рутовая view у ячеек - contentView
        contentView.addSubview(backView)
        contentView.addSubview(backView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        
        // нельзя устанавливать констрейнты, пока на вью не добавлен элемент
        NSLayoutConstraint.activate([
            
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
