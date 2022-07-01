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

        newsAPI.fetchNews { result in
            switch result {
            case .success(let newsItems):
                print(newsItems)
                // print(newsItems.first?.group)
                print(#function)
            case .failure(let error):
                print("fetchNews Error")
            }
            print(result)
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
        let item = newsArray[indexPath.section]
        let newsItemCellType = NewsItemCell(rawValue: indexPath.row)
        
        switch newsItemCellType {
        case .author:
           //return UITableViewCell() let cell = tableView.dequeueReusableCell(withIdentifier: <#T##String#>, for: <#T##IndexPath#>)
            return UITableViewCell()
        case .text:
            return UITableViewCell()
        case .photo:
            return UITableViewCell()
        case .likeCount:
            return UITableViewCell()
        case .none:
            return UITableViewCell()
        }
    }
}
