//
//  FriendsViewController.swift
//  VK-TrainingApp
//
//  Created by mac on 27.04.2022.
//

import UIKit

class FriendsViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        
        //VC -> tableView -> methods -> delegate/datasource -> VC (dvustoronyaya svyaz)
        //
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0)
        ])
        
        print(User.shared)
        print(User.shared.token)
        print(User.shared.userID)
    }
}

extension FriendsViewController: UITableViewDelegate {
    
}

extension FriendsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "cell",
            for: indexPath)
        cell.textLabel?.text = "Hello"
        return cell
    }
}


