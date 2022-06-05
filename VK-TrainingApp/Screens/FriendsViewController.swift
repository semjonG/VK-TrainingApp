//
//  FriendsViewController.swift
//  VK-TrainingApp
//
//  Created by mac on 27.04.2022.
//

import UIKit

class FriendsViewController: UIViewController {
    
    // inject service with vareable. внедрили зависимость в контроллер (переменная сервиса) через сильную ссылку
    var friendsAPI = FriendsAPI()
    
    var friends: [Friend] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        
        //VC -> tableView -> methods -> delegate/datasource -> VC (dvustoronyaya svyaz)
        //
        tableView.delegate = self
        tableView.dataSource = self
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
    
    private func fetchFriends() {
        // closure, лежащий в параметре функции - колл бэк (обратный вызов функции)
        friendsAPI.fetchFriends { result in
            switch result {
                
#warning("разобрать паттерн matching в switch, case let in switch")
                
            case .success(let friends):
                self.friends = friends
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension FriendsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажатие", indexPath.row)
    }
}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: FriendCell = tableView.dequeueReusableCell(withIdentifier: FriendCell.identifier, for: indexPath) as! FriendCell

        let friend = friends[indexPath.row]
        cell.configure(friend)
        
        return cell
    }
}



