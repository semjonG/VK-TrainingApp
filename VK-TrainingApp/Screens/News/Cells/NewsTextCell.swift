//
//  NewsTextCell.swift
//  VK-TrainingApp
//
//  Created by mac on 01.07.2022.
//

import UIKit

class NewsTextCell: UITableViewCell {
    
    static let identifier = "NewsTextCell"
 
    lazy var newsTextLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    // MARK: - Lifecycle
    
    override func prepareForReuse() {
        newsTextLabel.text = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Public
    func configure(_ newsText: String) {
        
        newsTextLabel.text = newsText
    }
    
    // MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(newsTextLabel)
        
        NSLayoutConstraint.activate([
            
            newsTextLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            newsTextLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            newsTextLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            newsTextLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
    
    private func setupConstraints() {
        
       
    }
}
