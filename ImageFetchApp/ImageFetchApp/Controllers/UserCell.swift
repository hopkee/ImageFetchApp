//
//  UserCell.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(_ user: User) {
        userNameLbl.text = user.name
        phoneLbl.text = user.phone
        emailLbl.text = user.email
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
