//
//  ApiService.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit

final class ApiService: UIViewController {

    static func getUserPosts(userId: Int) -> [Post] {
        
        var posts: [Post] = []
        let url = URL(string: ApiConstants.remotePostPath + "?userId=" + String(userId))!
        
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
}
