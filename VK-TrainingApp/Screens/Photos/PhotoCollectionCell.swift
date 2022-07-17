//
//  PhotoCollectionCell.swift
//  VK-TrainingApp
//
//  Created by mac on 14.06.2022.
//

import UIKit
import SDWebImage

final class PhotoCollectionCell: UICollectionViewCell {
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
//        label.backgroundColor = .systemBackground
        return label
    }()
    
    lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
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
    

    // MARK: - cell shadow settings
    override func layoutSubviews() {
        contentView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 8
        backView.clipsToBounds = true
        
        contentView.layer.shadowColor = UIColor.gray.cgColor
        contentView.layer.shadowOpacity = 1
        contentView.layer.shadowOffset = .zero
    }
    
    // MARK: - Public
    // тут ссылки на данные
    func configure(_ photo: Photo) {
        
        self.photoImageView.sd_setImage(with: URL(string: photo.largePhotoURL), completed: nil)

        self.likeLabel.text = ""
    }
    
    // MARK: - Private
    
    private func setupViews() {
        // рутовая view у ячеек - contentView
        contentView.addSubview(backView)
        contentView.addSubview(photoImageView)
        contentView.addSubview(likeLabel)
    }
    
    private func setupConstraints() {
        backView.pinEdgesToSuperView(top: 0, bottom: 0, left: 0, right: 0)
        
        NSLayoutConstraint.activate([
            
            photoImageView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 0),
            photoImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 0),
            photoImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: 0),
            photoImageView.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: 0),
            
            
            likeLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20),
            likeLabel.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 20),
            likeLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20)
        ])
    }
}
