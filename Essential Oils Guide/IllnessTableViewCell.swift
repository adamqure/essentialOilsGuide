//
//  IllnessTableViewCell.swift
//  Essential Oils Guide
//
//  Created by Adam Ure on 9/29/18.
//  Copyright © 2018 App Development with Swift. All rights reserved.
//

import UIKit

class IllnessTableViewCell: UITableViewCell {
    @IBOutlet weak var illnessNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateIllness(illness: illness){
        illnessNameLabel.text = illness.name
    }
}
