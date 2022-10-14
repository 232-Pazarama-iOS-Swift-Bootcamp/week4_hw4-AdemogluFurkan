//
//  PhotoTableViewCell.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 14.10.2022.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    var title : String? {
        set {
            titleLabel.text = newValue
        }
        get {
            titleLabel.text
        }
    }
    
    @IBOutlet private(set) weak var photoImageView:UIImageView!
    @IBOutlet private weak var titleLabel:UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
