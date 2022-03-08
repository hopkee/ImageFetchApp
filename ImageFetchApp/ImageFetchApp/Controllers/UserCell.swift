//
//  UserCell.swift
//  ImageFetchApp
//
//  Created by Valya on 5.03.22.
//

import UIKit

final class UserCell: UITableViewCell {

    @IBOutlet weak private var userNameLbl: UILabel!
    @IBOutlet weak private var phoneLbl: UILabel!
    @IBOutlet weak private var emailLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
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
