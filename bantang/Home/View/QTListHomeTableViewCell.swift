//
//  QTListHomeTableViewCell.swift
//  bantang
//
//  Created by chenqitao on 2017/1/4.
//  Copyright © 2017年 陈齐涛. All rights reserved.
//

import UIKit
import Kingfisher

class QTListHomeTableViewCell: UITableViewCell {

    @IBOutlet weak var homeImageView: UIImageView!
    
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var searchCountLabel: UILabel!
    @IBOutlet weak var likesCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titlelabel.text = "sadasdasldjlaksjldjalskjdlksalkdjals"
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configCellWithModel(model:QTHomeModel) {
        titlelabel.text = model.title
        nameLabel.text = model.user.nickname
        searchCountLabel.text = model.views
        likesCountLabel.text = model.likes
        homeImageView.kf.setImage(with: URL(string:model.pic), placeholder: nil, options: [.transition(ImageTransition.fade(1))], progressBlock: { receivedSize, totalSize in
            print(receivedSize/totalSize)
        }) { (image, error, cacheType, imageURL) in
        }
    }
}
    

