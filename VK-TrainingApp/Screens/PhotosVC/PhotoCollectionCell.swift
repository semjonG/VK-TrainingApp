//
//  PhotoCollectionCell.swift
//  VK-TrainingApp
//
//  Created by mac on 14.06.2022.
//

import UIKit
import SDWebImage

class PhotoCollectionCell: UICollectionViewCell {
    static let identifier = "PhotoCollectionCell"
    
    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var likeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        return label
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        self.photoImageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
 
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)

        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    // MARK: - cell shadow
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 25
        backView.clipsToBounds = true
        
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = .zero
    }
    
    // MARK: - Public
    // тут ссылки на данные
    func configure(_ photo: Photo) {
        
//        self.photoImageView.sd_setImage(with: URL(string: photo.photo100 ?? ""), completed: nil)
        
        self.photoImageView.image = UIImage(named: "testPic")

        self.likeLabel.text = "❤️ 100"
    }
    
    // MARK: - Private
    
    private func setupViews() {
        // рутовая view у ячеек - contentView
        contentView.addSubview(backView)
        contentView.addSubview(likeLabel)
        contentView.addSubview(photoImageView)
    }
    
    private func setupConstraints() {
        backView.pinEdgesToSuperView(top: 0, bottom: 0, left: 0, right: 0)
        
        NSLayoutConstraint.activate([
            
            photoImageView.widthAnchor.constraint(equalToConstant: 100),
            photoImageView.heightAnchor.constraint(equalToConstant: 100),
            photoImageView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 25),
            photoImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            photoImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20),
            
            nameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20),
            nameLabel.leftAnchor.constraint(equalTo: photoImageView.rightAnchor, constant: 20),
            nameLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20)
        ])
    }
    
}
