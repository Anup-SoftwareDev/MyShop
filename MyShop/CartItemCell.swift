

import UIKit
import Firebase
import FirebaseFirestore
import FirebaseAuth

protocol CartItemCellDelegate: AnyObject {
    func didTapOnCellContent(cell: CartItemCell)
}

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
    
    weak var delegate: CartItemCellDelegate?

    override func awakeFromNib() {
            super.awakeFromNib()
        setupTapGestures()
        }
    
    private func setupTapGestures() {
         // Create UITapGestureRecognizer for each view
         let imageTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
         let labelTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
         let priceTapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))

         // Enable user interaction on each view
         cartItemImage.isUserInteractionEnabled = true
         cartItemLbl.isUserInteractionEnabled = true
         CartItemPrice.isUserInteractionEnabled = true

         // Add the gesture recognizer to each view
         cartItemImage.addGestureRecognizer(imageTapGesture)
         cartItemLbl.addGestureRecognizer(labelTapGesture)
         CartItemPrice.addGestureRecognizer(priceTapGesture)
     }

    @objc func handleTap() {
            delegate?.didTapOnCellContent(cell: self)
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
        removeIndexToDatabase()
        deleteButtonTapped?()
    }
    
    
    
    private func removeIndexToDatabase(){
        
        let database = Firestore.firestore()
        if let user = Auth.auth().currentUser, let email = user.email {
            let docRef = database.document("users/\(email)")
            let cartIndexNumbers = DataHolder.shared.cartIndexNumbers
            docRef.updateData(["cart": cartIndexNumbers])
            
        }
        
        }}
    




