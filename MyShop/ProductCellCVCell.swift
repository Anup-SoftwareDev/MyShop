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
   
    let productPrices = [ 259.99, 79.50, 1000.00, 799.99, 29.99, 42999.99, 499.99, 298.99]
    
    let productDescriptions: [String] = [
    "Experience unparalleled clarity with our cutting-edge HD Monitor, designed for both professional and entertainment needs. Elevate your viewing experience with superior display quality",
    "Capture moments with unmatched precision using the Fuji-X-S10, a fusion of advanced imaging technology and ergonomic design. Improve your photography game with its outstanding color reproduction, intuitive controls, and compact form factor.",
    "Latest phone with all the sought after features. The camera resolution is second to none. Also provides Facetime and very managable navigation.",
    "Unleash unparalleled productivity with the HP ProBook Laptop, a blend of robust performance and sleek design. Whether for business or leisure, its advanced features and durable build ensure you stay ahead in the digital age.",
    "Advance your interior aesthetics with this pristine white vase, a seamless blend of classic elegance and modern design. Whether holding flowers or standing alone, it serves as a captivating centerpiece for any space.",
    "Embody timeless elegance with the Omega Seamaster watch, a perfect union of precision engineering and sophisticated design. A testament to unparalleled craftsmanship, this timepiece not only tells time but narrates a legacy.",
    "Dive into the future of gaming with the Xbox 5, where power meets innovation to deliver breathtaking experiences. Seamlessly blending top-tier performance with cutting-edge design, this console is set to redefine your digital adventures.",
    "Revolutionize your shopping experience with our vibrant red cart, a perfect fusion of style and functionality. Designed for optimal convenience, its striking color not only grabs attention but ensures a smooth journey through aisles."
    ]
    
        
        
    
    

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
        
            // Set the border color, width, and optionally corner radius
        let customColor = UIColor(red: 189/255.0, green: 195/255.0, blue: 199/255.0, alpha: 1.0)
        layer.borderColor = customColor.cgColor

        layer.borderWidth = 0.35

        
        //#758AA2
    }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            //self.layer.cornerRadius = self.bounds.height * 0.05
            self.clipsToBounds = true
        }

        func configure(with index: Int) {
            let adjustedIndex = index % imageNames.count
            productImage.image = UIImage(named: imageNames[adjustedIndex])
            productNameLbl.text = productNames[adjustedIndex]
            //productPriceLbl.text = "A$ \(String(productPrices[adjustedIndex]))"
            
            productPriceLbl.text = String(format: "AU $%.2f", productPrices[adjustedIndex])
        }
    }

  
