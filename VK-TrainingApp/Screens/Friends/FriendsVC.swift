//
//  FriendsViewController.swift
//  VK-TrainingApp
//
//  Created by mac on 27.04.2022.
//

import UIKit

class FriendsVC: UIViewController {
    // Состояние-1: запрос НЕ запущен
    var friendsAreLoading = false
    
    // inject service with vareable. внедрили зависимость в контроллер (переменная сервиса) через сильную ссылку
    var friendsAPI = FriendsAPI()
    var friends: [Friend] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        //VC -> tableView -> methods -> delegate/datasource -> VC (dvustoronyaya svyaz)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self // позволяет подгрузку данных
        tableView.separatorColor = UIColor.clear
        tableView.register(FriendCell.self, forCellReuseIdentifier: FriendCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchFriends()
    }
    
    private func setupViews() {
        self.view.addSubview(tableView) // на рут вью кладем тейбл вью
        tableView.pinEdgesToSuperView()
    }
    
    private func fetchFriends(offset: Int = 0) {
        
        // closure, лежащий в параметре функции - колл бэк (обратный вызов функции)
        friendsAPI.fetchFriends(offset: offset) { result in
            switch result {
                
            case .success(let friends):
                self.friends = friends
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FriendsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажатие", indexPath.row)
    }
}

extension FriendsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FriendCell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as! FriendCell

        let friend = friends[indexPath.row]
        cell.configure(friend)
        cell.selectionStyle = .none
        return cell
    }
}

// дает массив indexpath. где мы можем узнать, на какой ячейке мы прокручиваем таблицу
extension FriendsVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.map { print($0.row, $0.section) }
        guard let maxRow = indexPaths.map({ $0.row }).max() else { return }
        
        if maxRow > friends.count - 5 {
//            self.fetchFriends(offset: friends.count)
            
            if friendsAreLoading == false {
                
                // Состояние-2: запрос запущен
                friendsAreLoading = true
                
                // запуск запроса
                friendsAPI.fetchFriends(offset: friends.count) { result  in
                    
                    // запрос уже загрузил данные и положил в result и снимаем защиту (false)
                    self.friendsAreLoading = false
                    
                    switch result {
                    case .success(let friends):
                        // добавляем массив из 20 друзей еще новый массив из 20 друзей из запроса
                        self.friends.append(contentsOf: friends)
                        self.tableView.reloadData()
                        
                    case .failure(_):
                        print("ошибка загрузки 20 друзей")
                    }
                }
            }
        }
    }
}




