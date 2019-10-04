//
//  CrewTableViewCell.swift
//  TV App
//
//  Created by Bindu on 08/01/18.
//  Copyright © 2018 xminds. All rights reserved.
//

import UIKit

class CrewTableViewCell: UITableViewCell {

    @IBOutlet weak var crewTypeLabel: UILabel!
    @IBOutlet weak var crewNameLabel: UILabel!
    @IBOutlet weak var crewImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setupWithCrew(crew: Crew) {
        crewImageView.sd_setImage(with: URL (string:crew.person!.image?.original ?? AppData.placeholderUrl), placeholderImage: nil)
        guard let personName = crew.person?.name else {
            return
        }
        guard let crewType = crew.type else {
            return
        }
        crewNameLabel.text =  "Name: " +  personName
        crewTypeLabel.text = "Type: " +  crewType
    }
}
