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

class NewsVC: UITableViewController {
    var newsAPI = NewsAPI()
    var newsArray: [NewsItem] = []
    
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
    
    // MARK: - TableView data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return newsArray.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return NewsItemCell.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let item = newsArray[indexPath.section]
        let newsItemCellType = NewsItemCell(rawValue: indexPath.row)
        
        switch newsItemCellType {
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.identifire, for: indexPath) as! NewsAuthorCell
            return cell
            
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.identifire, for: indexPath) as! NewsTextCell
            let text = newsArray[indexPath.row]
            cell.configure(text)
            return cell
            
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.identifire, for: indexPath) as! NewsPhotoCell
            let photo = newsArray[indexPath.row].photos?.items
            cell.configure(photo)
            return cell
            
        case .likeCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsLikesCell.identifire, for: indexPath) as! NewsLikesCell
            return cell
            
        case .none:
            return UITableViewCell()
        }
    }
}
