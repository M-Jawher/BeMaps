//
//  UsersCell.swift
//  Be Maps
//
//  Created by Mohammad Jawher on 10/11/2024.
//

import UIKit

class UsersCell: UITableViewCell {
    
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var lblUserId: UILabel!
    @IBOutlet weak var lblUsername: UILabel!
    
    func SetDataUsers(data: UsersM){
        self.lblUserId.text = "\(data.userId + 1)"
        self.lblUsername.text = data.userEmail
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor(red:39/255, green:169/255, blue:254/255, alpha: 1).cgColor
        self.view.layer.cornerRadius = 5
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
}
