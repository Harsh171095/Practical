//
//  ProductItemCell.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import UIKit
import SDWebImage

class ProductItemCell: UITableViewCell {

    @IBOutlet weak var itemView: UIView!
    @IBOutlet weak var imgItem: UIImageView!
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        itemView.backgroundColor = .white
        itemView.layer.cornerRadius = 10
        
        imgItem.layer.cornerRadius = 10
        imgItem.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
    }
    
    func setData(_ item: ProductItem) {
        imgItem.sd_setImage(with: URL(string: item.thumbnail), placeholderImage: UIImage(named: "placeholder"))
        lblItemName.text = item.title
        lblPrice.text = "$\(item.price)"
        lblCategory.text = item.category
    }

}
