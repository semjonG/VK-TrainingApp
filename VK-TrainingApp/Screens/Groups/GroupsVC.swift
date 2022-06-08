//
//  GroupsViewController.swift
//  VK-TrainingApp
//
//  Created by mac on 08.06.2022.
//

import UIKit

class GroupsVC: UIViewController {
    
    var groupsAPI = GroupsAPI()
    
    var groups: [Group] = []

    private lazy var tableView: UITableView = {
        let tableView = UITableView()

        tableView.delegate = self
        tableView.dataSource = self
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
        
        self.view.addSubview(tableView) // на рут вью кладем тейбл вью
        tableView.pinEdgesToSuperView()
    }
    
    private func fetchGroups() {
        // closure, лежащий в параметре функции - колл бэк (обратный вызов функции)
        groupsAPI.fetchGroups { result in
            switch result {
                
#warning("разобрать паттерн matching в switch, case let in switch")
                
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
