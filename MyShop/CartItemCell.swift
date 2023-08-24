

import UIKit

class CartItemCell: UITableViewCell {
    
    
    @IBOutlet weak var cartItemImage: UIImageView!
    
    @IBOutlet weak var cartItemLbl: UILabel!
    
    @IBOutlet weak var CartItemPrice: UILabel!
    
    
    @IBOutlet weak var deleteBtn: UIButton!
    
    var deleteButtonTapped: (() -> Void)?
    var productImage = "vase"
    var productLbl = "Vase"
    var productPrice = 1000.00
    var indexValue = 5
    
    override func awakeFromNib() {
            super.awakeFromNib()
            //configureCell()
        }

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
        }
        
    func configureCell(with image: String, label: String, price: Double, index: Int) {
           
            cartItemImage.image = UIImage(named: image)
            cartItemLbl.text = label
            CartItemPrice.text = String(format: "A$ %.2f", price)
            indexValue = index
        }
    
    @IBAction func deleteBtnClicked(_ sender: Any) {
        print("Index Value: \(indexValue)")
        // Remove index from cartIndexNumbers
                if !DataHolder.shared.cartIndexNumbers.isEmpty {
                    DataHolder.shared.cartIndexNumbers.remove(at: indexValue)
                }
        // Call the closure
        deleteButtonTapped?()
    }
}
    




