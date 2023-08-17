

import UIKit

class CartItemCell: UITableViewCell {
    
    
    @IBOutlet weak var cartItemImage: UIImageView!
    
    @IBOutlet weak var cartItemLbl: UILabel!
    
    @IBOutlet weak var CartItemPrice: UILabel!
    
    override func awakeFromNib() {
            super.awakeFromNib()
            configureCell()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
        func configureCell() {
            cartItemImage.image = UIImage(named: "laptop")
            cartItemLbl.text = "HP Laptop"
            CartItemPrice.text = "A$ 1000"
        }
    }
    




