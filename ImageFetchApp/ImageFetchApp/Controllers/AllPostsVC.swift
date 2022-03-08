//
//  AllPostsVC.swift
//  ImageFetchApp
//
//  Created by Valya on 7.03.22.
//

import UIKit
import Alamofire
import SwiftyJSON

final class AllPostsVC: UITableViewController {

    var userId: Int?
    var userName: String?
    var allUserPosts: [Post] = []
    var isDismissedForUserDetailView: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return allUserPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "AllPostsCell")
        cell.textLabel?.text = allUserPosts[indexPath.row].title
        cell.detailTextLabel?.text = allUserPosts[indexPath.row].body
        cell.textLabel?.numberOfLines = 0
        cell.detailTextLabel?.numberOfLines = 0

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "DetailedPost", sender: allUserPosts[indexPath.row])
    }
    
    func fetchData() {
        
        if let userId = self.userId,
           let url = URL(string: ApiConstants.postPath + "?userId=" + String(userId) + "&_sort=id&_order=desc") {

        AF.request(url, method: .get).responseData { response in
            switch response.result {
            case .success(let data):
                for index in 0..<JSON(data).count {
                    if let userId = JSON(data)[index]["userId"].int,
                       let id = JSON(data)[index]["id"].int,
                       let title = JSON(data)[index]["title"].string,
                       let body = JSON(data)[index]["body"].string {
                       let post = Post(userId: userId, id: id, title: title, body: body)
                       self.allUserPosts.append(post)
                    }
                }
                print(data)
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
                }
            }
        }
    }
    
    private func setUpUI() {
        if let username = userName {
            navigationItem.title = "All " + username + "s posts"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailedPostVC = segue.destination as? DetailedPostView,
           let post = sender as? Post {
            detailedPostVC.post = post
            detailedPostVC.username = userName
            detailedPostVC.isModalWasClosed = { [weak self] in
                self?.allUserPosts = []
                self?.fetchData()
                self?.isDismissedForUserDetailView!()
            }
        }
    }

}
