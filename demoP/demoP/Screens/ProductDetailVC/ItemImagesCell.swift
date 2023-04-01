//
//  ItemImagesCell.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import UIKit

class ItemImagesCell: UICollectionViewCell {

    @IBOutlet private weak var imgItem: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setImage(_ url : String) {
        imgItem.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "placeholder"))
    }

}
