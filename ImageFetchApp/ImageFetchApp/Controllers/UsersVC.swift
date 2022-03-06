//
//  UsersVC.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit

class UsersVC: UITableViewController {
    
    private var users: [User] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "UserCell", bundle: nil), forCellReuseIdentifier: "UserCell")
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return users.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as! UserCell
        let user = users[indexPath.row]
        cell.configure(user)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(70)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "GoToDetailedView", sender: indexPath.row)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    func fetchData() {
        
        guard let url = ApiConstants.remoteUsersURL else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            do {
                self.users = try JSONDecoder().decode([User].self, from: data)
                print(self.users)
            } catch let error {
                print(error)
            }
            
            DispatchQueue.main.async {
            self.tableView.reloadData()
            }
            
        }
        task.resume()
        
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailedView = segue.destination as? UserDetailedVC,
           let userId = sender as? Int {
            detailedView.userId = userId
            detailedView.fetchData()
        }
    }

}
