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
    
    
    @IBAction func addNewPostAction(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToAddNewPost", sender: nil)
    }
    
    @IBAction func viewAllPostsAction(_ sender: UIButton) {
        performSegue(withIdentifier: "GoToAllPosts", sender: nil)
    }
    
    var user: User?
    private var latestUserPosts: [Post] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        setUpUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.updateViewConstraints()
        self.tableViewHeight?.constant = self.tableViewPosts.contentSize.height
    }
    
    private func setUpTableView() {
        tableViewPosts.delegate = self
        tableViewPosts.dataSource = self
        tableViewPosts.separatorStyle = .singleLine
        tableViewPosts.contentInset = UIEdgeInsets(top: -27, left: 0, bottom: 0, right: 0)
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
           let url = URL(string: ApiConstants.postPath + "?userId=" + String(userId) + "&_sort=id&_order=desc") {

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
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let allPostsVC = segue.destination as? AllPostsVC,
           let userId = self.user?.id {
            allPostsVC.userId = userId
            allPostsVC.userName = self.user?.name
            allPostsVC.fetchData()
            allPostsVC.isDismissedForUserDetailView = { [weak self] in
                self?.latestUserPosts = []
                self?.fetchData()
             }
        }
        
        if let addNewPostVC = segue.destination as? AddNewPostVC,
           let userId = self.user?.id {
            addNewPostVC.userId = userId
            addNewPostVC.isDismissed = { [weak self] in
                self?.latestUserPosts = []
                self?.fetchData()
             }
        }
        
        if let detailedPostVC = segue.destination as? DetailedPostView,
           let post = sender as? Post,
           let username = user?.name {
            detailedPostVC.post = post
            detailedPostVC.username = username
            detailedPostVC.isModalWasClosed = { [weak self] in
                self?.latestUserPosts = []
                self?.fetchData()
            }
        }
        
    }
    
}
    

extension UserDetailedVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetailedPostView", sender: latestUserPosts[indexPath.row])
    }
    
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
