//
//  NewsVC.swift
//  VK-TrainingApp
//
//  Created by mac on 20.06.2022.
//

import UIKit

// энум - ограниченный набор данных 4-х типов ячеек
enum NewsItemCell: Int, CaseIterable {
    case author = 0
    case text
    case photo
    case likeCount
}

class NewsVC: UIViewController {
    
    var newsAPI = NewsAPI()
    var newsArray: [PostCellModel] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        
        tableView.delegate = self
        tableView.dataSource = self
        //        tableView.prefetchDataSource = self
        tableView.separatorColor = UIColor.clear
        
        tableView.register(NewsAuthorCell.self, forCellReuseIdentifier: NewsAuthorCell.identifier)
        tableView.register(NewsTextCell.self, forCellReuseIdentifier: NewsTextCell.identifier)
        tableView.register(NewsPhotoCell.self, forCellReuseIdentifier: NewsPhotoCell.identifier)
        tableView.register(NewsLikesCell.self, forCellReuseIdentifier: NewsLikesCell.identifier)

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
        
        let cellModel = newsArray[indexPath.section]
        let cellType = NewsItemCell(rawValue: indexPath.row)
        
        switch cellType {
        
        case .text:
            if cellModel.text.isEmpty {
                return CGFloat.zero
            }
   
        case .photo:
            if cellModel.photoUrl.isEmpty {
                return CGFloat.zero
            }

        default:
            return UITableView.automaticDimension
        }
        
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellType = NewsItemCell(rawValue: indexPath.row) // индекс -> в тип ячейки и далее свичем по кейсам
        
        let cellModel = newsArray[indexPath.section]
        
        
        switch cellType {
        case .author:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsAuthorCell.identifier, for: indexPath) as! NewsAuthorCell
            
            cell.configure(cellModel)
            cell.selectionStyle = .none
            return cell
            
        case .text:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsTextCell.identifier, for: indexPath) as! NewsTextCell

            cell.configure(cellModel)
            cell.selectionStyle = .none
            return cell
            
        case .photo:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsPhotoCell.identifier, for: indexPath) as! NewsPhotoCell

            cell.configure(cellModel)
            cell.selectionStyle = .none
            return cell
            
        case .likeCount:
            let cell = tableView.dequeueReusableCell(withIdentifier: NewsLikesCell.identifier, for: indexPath) as! NewsLikesCell

            cell.configure(cellModel)
            cell.selectionStyle = .none
            return cell
            
        default:
            return UITableViewCell()
        }
    }
}
