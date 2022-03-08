//
//  ApiService.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit
import SwiftyJSON
import Alamofire

final class ApiService: UIViewController {

    static func getUserPosts(userId: Int) -> [Post] {
        
        var posts: [Post] = []
        let url = URL(string: ApiConstants.postPath + "?userId=" + String(userId))!
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            do {
                posts = try JSONDecoder().decode([Post].self, from: data)
            } catch let error {
                print(error)
            }
            DispatchQueue.main.async {
            }
            
        }
        task.resume()
        return posts
    }
    
    static func getPostsByUserId(userId: Int, url: String) -> [Post] {
        
        var posts: [Post] = []
        
        if let url = URL(string: url + "?userId=" + String(userId)) {
            
            AF.request(url, method: .get).responseData { response in
                switch response.result {
                case .success(let data):
                    for index in 0...2 {
                        if let userId = JSON(data)[index]["userId"].int,
                           let id = JSON(data)[index]["id"].int,
                           let title = JSON(data)[index]["title"].string,
                           let body = JSON(data)[index]["body"].string {
                           let post = Post(userId: userId, id: id, title: title, body: body)
                           posts.append(post)
                        }
                    }
                    print(data)
                case .failure(let error):
                    print(error)
                    }
            }
            
            }
        return posts
    }
}
