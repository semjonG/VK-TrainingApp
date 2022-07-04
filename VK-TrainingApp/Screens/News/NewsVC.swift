//
//  NewsVC.swift
//  VK-TrainingApp
//
//  Created by mac on 20.06.2022.
//

import UIKit

enum NewsItemCell: Int, CaseIterable {
    case author = 0
    case text
    case photo
    case likeCount
}

class NewsVC: UIViewController {
    
    var newsAPI = NewsAPI()
    var newsArray: [NewsItem] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.prefetchDataSource = self
        //        tableView.separatorColor = UIColor.clear
        tableView.register(NewsAuthorCell.self, forCellReuseIdentifier: NewsAuthorCell.identifier)
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: NewsTextCell.identifier)
        tableView.register(NewsPhotoCell.self, forCellReuseIdentifier: NewsPhotoCell.identifier)
        tableView.register(NewsLikesCell.self, forCellReuseIdentifier: NewsLikesCell.identifier)
        
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchNews()
    }
    
    private func setupViews() {
        self.view.addSubview(tableView)
        tableView.pinEdgesToSuperView()
    }
    
    private func fetchNews() {
        newsAPI.fetchNews { result in
            switch result {
                
            case .success(let newsItems):
                self.newsArray = newsItems
                self.tableView.reloadData()
               
                print(#function)
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension NewsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажатие", indexPath.row)
    }
}

extension NewsVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsItemCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = newsArray[indexPath.section]
        let newsItemCellType = NewsItemCell(rawValue: indexPath.row)
        
        switch newsItemCellType {
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.identifier, for: indexPath) as! NewsAuthorCell
            return cell
            
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.identifier, for: indexPath) as! NewsTextCell
            let text = newsArray[indexPath.row]
            cell.configure(text)
            return cell
            
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.identifier, for: indexPath) as! NewsPhotoCell
            let photo = newsArray[indexPath.row].photos?.items
            cell.configure(photo)
            return cell
            
        case .likeCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsLikesCell.identifier, for: indexPath) as! NewsLikesCell
            let likes = newsArray[indexPath.row]
            cell.configure(likes)
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
}


