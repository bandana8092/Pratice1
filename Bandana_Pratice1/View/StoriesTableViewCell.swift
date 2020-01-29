//
//  StoriesTableViewCell.swift
//  Bandana_Pratice1
//
//  Created by Rakesh Nangunoori on 27/01/20.
//  Copyright © 2020 Rakesh Nangunoori. All rights reserved.
//

import UIKit

class StoriesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var label1: UILabel!
    
    @IBOutlet weak var label2: UILabel!
    
    @IBOutlet weak var statusSwitch: UISwitch!
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func updatePostCellUI(arrStory: [StoryModel], indexPath:IndexPath)
    {
        self.label1.text = arrStory[indexPath.row].title
        self.label2.text = ViewModel.shared.getFormattedDate(strServerDate: arrStory[indexPath.row].createDate)
        self.statusSwitch.isOn = arrStory[indexPath.row].selectedStatus
        self.contentView.backgroundColor = arrStory[indexPath.row].selectedStatus ? UIColor.lightGray : UIColor.white
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
