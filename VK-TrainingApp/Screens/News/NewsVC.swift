//
//  NewsVC.swift
//  VK-TrainingApp
//
//  Created by mac on 20.06.2022.
//

import UIKit

// энум - ограниченный набор данных 4-х типов ячеек
enum NewsItemCell: Int, CaseIterable {
    case author
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
    
//    кол-во секций = кол-ву новостей
//     1 секция = 1 новость
    func numberOfSections(in tableView: UITableView) -> Int {
        return newsArray.count
    }
    
//    секция - контейнер для ячеек (всегда содержит 4 ячейки)
//    1 секция = 4 ячейки
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsItemCell.allCases.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let newsItem = newsArray[indexPath.section]
        let newsItemCellType = NewsItemCell(rawValue: indexPath.row)
        switch newsItemCellType {
        
        case .text:
            print(newsItem.text)
            if newsItem.text == nil {
                return CGFloat.zero
            }
            
            if let text = newsItem.text, text.count == 0 {
                return CGFloat.zero
            }
            
            return UITableView.automaticDimension
            
            
        
            
        default:
            return UITableView.automaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let newsItemCellType = NewsItemCell(rawValue: indexPath.row) // индекс -> в тип ячейки и далее свичем по кейсам
        
        switch newsItemCellType {
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.identifier, for: indexPath) as! NewsAuthorCell
            let newsItem = newsArray[indexPath.section]
            
            #warning("Передавать source_id и внутри уже вытаскивать")
            if let group = newsItem.group {
                cell.configure(group)
            }
            
            if let profile = newsItem.profile {
                cell.configure(profile)
            }
            
            return cell
            
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.identifier, for: indexPath) as! NewsTextCell

            let newsItem = newsArray[indexPath.section]
            
            guard let text = newsItem.text else {
                //cell.isHidden = true
                //return cell
                return UITableViewCell()
            }
            cell.configure(text)
  
            return cell
            
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.identifier, for: indexPath) as! NewsPhotoCell
            
            let newsItem = newsArray[indexPath.section]
            guard let photos = newsItem.photos?.items else { return UITableViewCell() }
            cell.configure(photos)
            return cell
            
        case .likeCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsLikesCell.identifier, for: indexPath) as! NewsLikesCell

            let newsItem = newsArray[indexPath.section]
            guard let likes = newsItem.likes?.count
            else {
                cell.configure(likes: 0)
                return cell
            }
            
            cell.configure(likes: likes)
            
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
}
