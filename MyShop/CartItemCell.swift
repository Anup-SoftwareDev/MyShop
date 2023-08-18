

import UIKit

class CartItemCell: UITableViewCell {
    
    
    @IBOutlet weak var cartItemImage: UIImageView!
    
    @IBOutlet weak var cartItemLbl: UILabel!
    
    @IBOutlet weak var CartItemPrice: UILabel!
    
    var productImage = "vase"
    var productLbl = "Vase"
    var productPrice = 1000.00
    
    override func awakeFromNib() {
            super.awakeFromNib()
            //configureCell()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
        func configureCell(with image: String, label: String, price: Double) {
            cartItemImage.image = UIImage(named: image)
            cartItemLbl.text = label
            CartItemPrice.text = String(format: "A$ %.2f", price)
        }
    
      }
    




