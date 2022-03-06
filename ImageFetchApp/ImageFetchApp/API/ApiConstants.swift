//
//  ApiConstants.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit

class ApiConstants {
    
    static let serverPath = "http://localhost:3000/"
    static let postPath = serverPath + "posts"
    static let remotePostPath = "https://jsonplaceholder.typicode.com/posts"
    static let commentsPath = serverPath + "comments"
    static let postPathURL = URL(string: postPath)
    static let commentsPathURL = URL(string: commentsPath)
    static let remoteUsersURL = URL(string: "https://jsonplaceholder.typicode.com/users")
}
