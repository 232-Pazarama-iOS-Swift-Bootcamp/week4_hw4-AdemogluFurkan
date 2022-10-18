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
    
    var addFavoriteBtn : (() -> ())?
    
    @IBOutlet private(set) weak var photoImageView:UIImageView!
    @IBOutlet private weak var titleLabel:UILabel!

    @IBOutlet weak var addFavorite: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func favoriteButtonTapped(_ sender:Any){
        addFavoriteBtn!()
    }

}
