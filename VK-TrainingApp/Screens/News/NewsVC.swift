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
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.identifire, for: indexPath) as! NewsAuthorCell
            let nameUser = newsArray[indexPath.section].profile?.screenName ?? "nameUser error"
            let photoUser = newsArray[indexPath.section].profile?.photo50 ?? "photoUser error"
            cell.configure(photo: photoUser , name: nameUser)
//            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.identifire, for: indexPath) as! NewsTextCell
            cell.configure(<#T##friend: Friend##Friend#>) // РАСШИРИТЬ КОНСТРУКТОР ПОСЛЕ НАПИСАНИЯ КОНФИГУРА В ЯЧЕЙКЕ
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.identifire, for: indexPath) as! NewsPhotoCell
            cell.configure(<#T##friend: Friend##Friend#>) // РАСШИРИТЬ КОНСТРУКТОР ПОСЛЕ НАПИСАНИЯ КОНФИГУРА В ЯЧЕЙКЕ
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: .greatestFiniteMagnitude)
            return cell
        case .likeCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsLikesCell.identifire, for: indexPath) as! NewsLikesCell
            cell.configure(<#T##friend: Friend##Friend#>) // РАСШИРИТЬ КОНСТРУКТОР ПОСЛЕ НАПИСАНИЯ КОНФИГУРА В ЯЧЕЙКЕ
            
            return cell
        case .none:
            return UITableViewCell()
        }
    }
}
