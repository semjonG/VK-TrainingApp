//
//  NewsTextCell.swift
//  VK-TrainingApp
//
//  Created by mac on 01.07.2022.
//

import UIKit

class NewsTextCell: UITableViewCell {
    
    static let identifier = "NewsTextCell"

    let newsTextView: UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont.systemFont(ofSize: 14)
        return textView
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
    func configure(newsText: String?) {
        newsTextView.text = newsText 
    }
    
    // MARK: - Private
    
    private func setupViews() {
        contentView.addSubview(newsTextView)
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            newsTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            newsTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            newsTextView.leftAnchor.constraint(equalTo: contentView.rightAnchor, constant: 20),
            newsTextView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20)
        ])
    }
}
