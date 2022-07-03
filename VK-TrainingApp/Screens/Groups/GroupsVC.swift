//
//  GroupsViewController.swift
//  VK-TrainingApp
//
//  Created by mac on 08.06.2022.
//

import UIKit

class GroupsVC: UIViewController {
    
    var groupsAreLoading = false
    
    var groupsAPI = GroupsAPI()
    
    var groups: [Group] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.delegate = self
        tableView.dataSource = self
        tableView.prefetchDataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.register(GroupCell.self, forCellReuseIdentifier: GroupCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        fetchGroups()
    }
    
    private func setupViews() {
        
        self.view.addSubview(tableView) 
        tableView.pinEdgesToSuperView()
    }
    
    private func fetchGroups(offset: Int = 0) {
        // closure, лежащий в параметре функции - колл бэк (обратный вызов функции)
        groupsAPI.fetchGroups { result in
            switch result {
                
            case .success(let groups):
                self.groups = groups
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

extension GroupsVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("нажатие", indexPath.row)
    }
}

extension GroupsVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: GroupCell = tableView.dequeueReusableCell(withIdentifier: GroupCell.identifier, for: indexPath) as! GroupCell

        let group = groups[indexPath.row]
        cell.configure(group)
        
        return cell
    }
}

extension GroupsVC: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.map { print($0.row, $0.section) }
        guard let maxRow = indexPaths.map({ $0.row }).max() else { return }
        
        if maxRow > groups.count - 5 {
//
            
            if groupsAreLoading == false {
                
                // Состояние-2: запрос запущен
                groupsAreLoading = true
                
                // запуск запроса
                groupsAPI.fetchGroups(offset: groups.count) { result  in
                    
                    // запрос уже загрузил данные и положил в result и снимаем защиту (false)
                    self.groupsAreLoading = false
                    
                    switch result {
                    case .success(let groups):
                        // добавляем массив из 20 друзей еще новый массив из 20 друзей из запроса
                        self.groups.append(contentsOf: groups)
                        self.tableView.reloadData()
                        
                    case .failure(_):
                        print("ошибка загрузки 20 друзей")
                    }
                }
            }
        }
    }
}
