//
//  NewsLikesCell.swift
//  VK-TrainingApp
//
//  Created by mac on 01.07.2022.
//

import UIKit

class NewsLikesCell: UITableViewCell {
    
    static let identifier = "NewsLikesCell"

    lazy var newsLikesLabel: UILabel = {
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
    func configure(likes: Int?) {
        newsLikesLabel.text = "\(likes)" 
    }
    
    // MARK: - Private
    
    private func setupViews() {
        // рутовая view у ячеек - contentView
        contentView.addSubview(newsLikesLabel)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            newsLikesLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            newsLikesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            newsLikesLabel.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            newsLikesLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
