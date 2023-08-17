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
  

    let imageNames = ["monitor", "camera", "iphone", "laptop", "vase", "watch", "xbox", "shopCart"]
    let productNames = ["Full-HD Monitor", "Fuji-X-S10", "iPhone Pro Max", "HP Pro-Book", "Ceramic Vase", "Omega Seamaster", "Xbox-5", "Red Shop-Cart"]
    // let productPrices = ["A$ 259.99", "A$ 79.50", "$ 1000.00", "A$ 799.99", "A$ 29.99", "$42 999.99", "A$ 499.99", "A$298.99"]
    let productPrices = [ 259.99, 79.50, 1000.00, 799.99, 29.99, 42999.99, 499.99, 298.99]
        
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

        func configure(with index: Int) {
            let adjustedIndex = index % imageNames.count
            productImage.image = UIImage(named: imageNames[adjustedIndex])
            productNameLbl.text = productNames[adjustedIndex]
            productPriceLbl.text = "A$ \(String(productPrices[adjustedIndex]))"
            
        }
    }

  
