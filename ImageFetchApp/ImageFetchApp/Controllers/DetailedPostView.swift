//
//  DetailedPostView.swift
//  ImageFetchApp
//
//  Created by Valya on 8.03.22.
//

import UIKit
import Alamofire

final class DetailedPostView: UIViewController {
    
    var post: Post?
    var username: String?
    var isModalWasClosed: (()-> Void)?
    
    @IBOutlet weak private var postLabel: UILabel!
    @IBOutlet weak private var titleTextLbl: UILabel!
    @IBOutlet weak private var bodyTextLbl: UILabel!
    
    @IBAction private func deletePostBtn() {
        deletePostRequest()
        dismiss(animated: true, completion: nil)
        isModalWasClosed?()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        
    }

    private func setUpUI() {
        if let username = username {
            postLabel.text = "Post from " + username
        }
        titleTextLbl.text = post?.title
        bodyTextLbl.text = post?.title
    }
    
    private func deletePostRequest() {
        
        if let postId = post?.id,
           let url = URL(string: ApiConstants.postPath + "/" + String(postId)) {

            AF.request(url, method: .delete).response { response in
                debugPrint(response)
            }
        }
    }
    
}
