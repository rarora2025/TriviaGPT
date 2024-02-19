//
//  LiveEventCell.swift
//  June20Proj
//
//  Created by Rahul on 7/13/20.
//  Copyright © 2020 Rahul. All rights reserved.
//

import UIKit
protocol TableViewNew {
    func onClickCell(index: Int)
}
class LiveEventCell: UITableViewCell {

    var cellDelegate: TableViewNew?
    var index: IndexPath?

    @IBAction func clicked(_ sender: UIButton) {
                  
        
    }
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var realbutton: UIButton!
    
    @IBOutlet weak var enter1: UIButton!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var name2: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var date: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
