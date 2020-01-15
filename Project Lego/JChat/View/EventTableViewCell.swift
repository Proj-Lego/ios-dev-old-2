//
//  EventTableViewCell.swift
//  Lego
//
//  Created by Abhinav Pottabathula on 1/14/20.
//  Copyright © 2020 lego. All rights reserved.
//

import Foundation
import AlamofireImage

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var eventImageView: UIImageView!
    @IBOutlet weak var makerImageView: UIImageView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(with viewModel: EventListViewModel) {
        eventImageView.af_setImage(withURL: viewModel.imageUrl)
        eventNameLabel.text = viewModel.name
        locationLabel.text = viewModel.formattedDistance
    }

}
