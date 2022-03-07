//
//  UserDetailedVC.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit
import Alamofire
import SwiftyJSON

final class UserDetailedVC: UIViewController {

    @IBOutlet weak private var usernameLbl: UILabel!
    @IBOutlet weak private var tableViewPosts: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    
    var user: User?
    private var latestUserPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableViewHeight?.constant = self.tableViewPosts.contentSize.height + 65
    }
    
    private func setUpTableView() {
        tableViewPosts.delegate = self
        tableViewPosts.dataSource = self
        tableViewPosts.separatorStyle = .singleLine
    }
    
    private func setUpUI() {
        if let user = self.user,
           let username = user.name {
            usernameLbl.text = username
        }
    }
    
    func fetchData() {
        if let user = self.user,
           let userId = user.id,
           let url = URL(string: ApiConstants.remotePostPath + "?userId=" + String(userId)) {
        
        AF.request(url, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                for index in 0...2 {
                    if let userId = JSON(data)[index]["userId"].int,
                       let id = JSON(data)[index]["id"].int,
                       let title = JSON(data)[index]["title"].string,
                       let body = JSON(data)[index]["body"].string {
                       let post = Post(userId: userId, id: id, title: title, body: body)
                       self.latestUserPosts.append(post)
                    }
                }
                print(data)
                self.tableViewPosts.reloadData()
            case .failure(let error):
                print(error)
                }
        }
//        let url = URL(string: ApiConstants.remotePostPath + "?userId=" + String(self.userId!))!
//
//        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
//
//            guard let data = data else { return }
//            do {
//                    self.latestUserPosts = try JSONDecoder().decode([Post].self, from: data)
//
//            } catch let error {
//                print(error)
//            }
//
//            DispatchQueue.main.async {
//            self.tableViewPosts.reloadData()
//            }
//
//        }
//        task.resume()
        }
        
    }
    

}

extension UserDetailedVC: UITableViewDelegate {
    
    
}

extension UserDetailedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return latestUserPosts.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "PostCell")
        cell.textLabel?.text = latestUserPosts[indexPath.row].title
        cell.detailTextLabel?.text = latestUserPosts[indexPath.row].body
        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.numberOfLines = 2
        cell.detailTextLabel?.numberOfLines = 3

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        self.viewWillLayoutSubviews()
    }
    
}
