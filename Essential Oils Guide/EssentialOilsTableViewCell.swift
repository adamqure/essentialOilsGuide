//
//  EssentialOilsTableViewCell.swift
//  Essential Oils Guide
//
//  Created by Adam Ure on 8/27/18.
//  Copyright © 2018 App Development with Swift. All rights reserved.
//

import UIKit

class EssentialOilsTableViewCell: UITableViewCell {

    @IBOutlet weak var oilImageView: UIImageView!
    @IBOutlet weak var oilNameLabel: UILabel!
    @IBOutlet weak var oilDescriptionLabel: UILabel!
    
    func update(with singleOil: singleOil){
        oilNameLabel.text = singleOil.name
        oilDescriptionLabel.text = "Single Oil"
        if (UIImage(named: singleOil.name) != nil){
            oilImageView.image = UIImage(named: singleOil.name)
        } else {
            oilImageView.image = UIImage(named: "addImage")
        }
    }
    
    func update(with oilBlend: oilBlend) {
        oilNameLabel.text = oilBlend.name
        oilDescriptionLabel.text = "Oil Blend"
        if (UIImage(named: oilBlend.name) != nil){
            oilImageView.image = UIImage(named: oilBlend.name)
        } else {
            oilImageView.image = UIImage(named: "addImage")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
