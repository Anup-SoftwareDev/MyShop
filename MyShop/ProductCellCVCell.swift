//
//  ProductCellCVCell.swift
//  MyShop
//
//  Created by Anup Kuriakose on 5/8/2023.
//

import UIKit

class ProductCellCVCell: UICollectionViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productNameLbl: UILabel!
    
    @IBOutlet weak var productPriceLbl: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            // Initialize the corner radius for labels
            self.layoutIfNeeded() // Make sure all subviews have their frame layout
            self.productNameLbl.layer.cornerRadius = self.productNameLbl.bounds.height * 0.30
            self.productPriceLbl.layer.cornerRadius = self.productPriceLbl.bounds.height * 0.30
            self.productImage.layer.cornerRadius = self.productImage.bounds.height * 0.05
            self.productNameLbl.clipsToBounds = true
            self.productPriceLbl.clipsToBounds = true
            self.productImage.clipsToBounds = true
        }
    
    override func layoutSubviews() {
            super.layoutSubviews()
            self.layer.cornerRadius = self.bounds.height * 0.05
            self.clipsToBounds = true
        }
}
