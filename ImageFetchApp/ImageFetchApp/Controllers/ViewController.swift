//
//  ViewController.swift
//  ImageFetchApp
//
//  Created by Valya on 28.02.22.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet weak private var imageView: UIImageView!
    
    @IBAction private func dwnlBtn() {
        fetchImages()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }

    private func fetchImages() {
        
        guard let url = URL(string: imagesURLS[Int.random(in: 0..<imagesURLS.count)]) else { return }
                    
                let session = URLSession.shared

                let task = session.dataTask(with: url) { data, response, error in
                    
                        DispatchQueue.main.async {

                            if let error = error {
                                self.showAlert(error.localizedDescription)
                                return
                            }

                            print("\n", data ?? "", "\n")
                            if let data = data, let image = UIImage(data: data) {
                                    self.imageView.image = image
                               
                            }
                            
                        }
                    }
                    task.resume()
    }
    
    private func showAlert(_ message: String) {
        
        let dialogMessage = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
         })
        
        dialogMessage.addAction(ok)
      
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
}

