//
//  AddNewPostVC.swift
//  ImageFetchApp
//
//  Created by Valya on 7.03.22.
//

import UIKit
import Alamofire
import SwiftyJSON

final class AddNewPostVC: UIViewController {

    @IBOutlet weak private var textView: UITextView!
    
    @IBAction private func titleTextField(_ sender: UITextField) {
        newPostTitle = sender.text
        isEligibleToPost()
    }
    @IBOutlet weak private var postBtn: UIButton!
    @IBOutlet weak private var titleTextFieldOutlet: UITextField!
    
    @IBAction private func createNewPostBtn() {
        postData()
        dismiss(animated: true, completion: nil)
        self.isDismissed?()
    }
    
    var isDismissed: (() -> Void)?
    private var newPostTitle: String?
    private var newPostBody: String?
    var userId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
    }

    private func isEligibleToPost() {
        if let title = newPostTitle,
           let body = newPostBody {
            if title.count > 0 && body.count > 0 {
                postBtn.isEnabled = true
            } else {
                postBtn.isEnabled = false
            }
        }
    }
    
    private func postData() {
        
        if let title = titleTextFieldOutlet.text,
           let body = textView.text,
           let userId = self.userId,
           let url = URL(string: ApiConstants.postPath + "?userId=" + String(userId)) {
            
                let newPost = Post(userId: userId, id: nil, title: title, body: body)
            
                AF.request(url, method: .post, parameters: newPost, encoder: JSONParameterEncoder.default).response { response in
                debugPrint(response)
            }
        }
    }
    
}

extension AddNewPostVC: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        newPostBody = textView.text
        isEligibleToPost()
    }
    
}
