//
//  NewsVC.swift
//  VK-TrainingApp
//
//  Created by mac on 20.06.2022.
//

import UIKit

enum PostCellType: Int, CaseIterable {
    case author = 0
    case text
    case photo
    case likeCount
}

class NewsVC: UITableViewController {
    var newsAPI = NewsAPI()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        newsAPI.fetchNews { result in
            switch result {
            case .success(let newsItems):
                print(newsItems.first)
                print(#function)
            case .failure(let error):
                print("fetchNews Error")
            }
            print(result)
        }
    }
    
    // MARK: - TableView data source
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return Ne
//    }


}
