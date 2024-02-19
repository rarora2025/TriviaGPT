//
//  FriendsTableViewCell.swift
//  June20Proj
//
//  Created by Rahul on 7/8/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit

class FriendsTableViewCell: UITableViewCell {
    
    var link: FriendsTableViewController!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       
        super.init(style: FriendsTableViewCell.CellStyle.subtitle, reuseIdentifier: reuseIdentifier)
        
        
    
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
        
        let mySwitch = UIButton(type: .system)
             
             mySwitch.setImage(UIImage(systemName: "plus.circle"), for: .normal)
             mySwitch.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            
             mySwitch.addTarget(self, action: #selector(handleFriend), for: .touchUpInside)
        
          self.accessoryView = mySwitch
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @objc func handleFriend(_ sender: Any){
        
        link?.someMethodIWantToCall(cell: self)
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
