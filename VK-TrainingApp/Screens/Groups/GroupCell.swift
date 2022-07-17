//
//  GroupCell.swift
//  VK-TrainingApp
//
//  Created by mac on 08.06.2022.
//

import UIKit
import SDWebImage
import SnapKit

final class GroupCell: UITableViewCell {
    
    static let identifier = "GroupCell"

    lazy var backView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30
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
    func configure(_ group: Group) {
        
        self.logoImageView.sd_setImage(with: URL(string: group.photo100 ?? ""), completed: nil)

        self.logoImageView.contentMode = .scaleAspectFill

        self.nameLabel.text = "\(group.name ?? "")"
    }
    
    // MARK: - Private
    
    private func setupViews() {
        // рутовая view у ячеек - contentView
        contentView.addSubview(backView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(logoImageView)
    }
    
    private func setupConstraints() {
        backView.pinEdgesToSuperView(top: 10, bottom: 10, left: 20, right: 20)
        
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.left.equalTo(backView.snp_leftMargin).offset(10)
            make.top.equalTo(backView.snp_topMargin).offset(10)
            make.bottom.equalTo(backView.snp_bottomMargin).offset(-10)
        }

        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(backView.snp_topMargin).offset(20)
            make.bottom.equalTo(backView.snp_bottomMargin).offset(-20)
            make.left.equalTo(logoImageView.snp_rightMargin).offset(20)
            make.right.equalTo(backView.snp_rightMargin).offset(-20)
        }

        // нельзя устанавливать констрейнты, пока на вью не добавлен элемент
//        NSLayoutConstraint.activate([
//
//            logoImageView.widthAnchor.constraint(equalToConstant: 80),
//            logoImageView.heightAnchor.constraint(equalToConstant: 80),
//            logoImageView.leftAnchor.constraint(equalTo: backView.leftAnchor, constant: 25),
//            logoImageView.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
//            logoImageView.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20),
//
//            nameLabel.topAnchor.constraint(equalTo: backView.topAnchor, constant: 20),
//            nameLabel.bottomAnchor.constraint(equalTo: backView.bottomAnchor, constant: -20),
//            nameLabel.leftAnchor.constraint(equalTo: logoImageView.rightAnchor, constant: 20),
//            nameLabel.rightAnchor.constraint(equalTo: backView.rightAnchor, constant: -20)
//        ])
    }
}

