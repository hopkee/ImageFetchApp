//
//  UserDetailedVC.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit

class UserDetailedVC: UIViewController {

    @IBOutlet weak var usernameLbl: UILabel!
    @IBOutlet weak var tableViewPosts: UITableView!
    
    var userId: Int?
    var latestUserPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewPosts.delegate = self
        tableViewPosts.dataSource = self
        tableViewPosts.separatorStyle = .singleLine
    }

}

extension UserDetailedVC: UITableViewDelegate {
    
    
}

extension UserDetailedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PostCell")
        cell.textLabel?.text = latestUserPosts[indexPath.row].title
        cell.detailTextLabel?.text = latestUserPosts[indexPath.row].body
        cell.accessoryType = .disclosureIndicator

        return cell
        
    }
    
    func fetchData() {
        
        let url = URL(string: ApiConstants.remotePostPath + "?userId=" + String(self.userId!))!
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            do {
                self.latestUserPosts = try JSONDecoder().decode([Post].self, from: data)
            } catch let error {
                print(error)
            }
            
        }
        task.resume()
    }

}
