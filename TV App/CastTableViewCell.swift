//
//  ActorsTableViewCell.swift
//  TV App
//
//  Created by Bindu on 13/12/16.
//  Copyright © 2016 xminds. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {
    
    @IBOutlet var actorImageView: UIImageView!
    @IBOutlet var actorNameLabel: UILabel!
    @IBOutlet var actorRoleLabel: UILabel!
    @IBOutlet var roleImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actorImageView.layer.cornerRadius = actorImageView.frame.size.height/2
        roleImageView.layer.cornerRadius = roleImageView.frame.size.height/2
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupWithCast(cast: Cast) {
        actorImageView.sd_setImage(with: URL (string:cast.person?.image?.original ?? AppData.placeholderUrl), placeholderImage: nil)
        actorNameLabel.text = "Name: " + (cast.person?.name ?? "" )
        actorRoleLabel.text = "Role: " + (cast.character?.name ?? "")
        roleImageView.sd_setImage(with: URL (string:cast.character!.image?.original ?? AppData.placeholderUrl), placeholderImage: nil)
    }
    
}
