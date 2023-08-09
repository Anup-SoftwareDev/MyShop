//
//  ViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 4/8/2023.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var loginBtn: UIBarButtonItem!
    @IBOutlet weak var collectionView: UICollectionView! // Connect this outlet to your UICollectionView in the storyboard

    override func viewDidLoad() {
            super.viewDidLoad()
            setupCollectionView()
        }
        
        private func setupCollectionView() {
            // Register the xib for the collection view cell
            let nib = UINib(nibName: "ProductCellCVCell", bundle: nil)
            collectionView.register(nib, forCellWithReuseIdentifier: "ProductCellCVCell")
            
            // Set the collection view's data source and delegate
            collectionView.dataSource = self
            collectionView.delegate = self
        }

}

// MARK: - UICollectionViewDataSource
extension ViewController {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20 // You mentioned you want it repeated 4 times
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCellCVCell", for: indexPath) as! ProductCellCVCell
        // Configure cell if needed
        return cell
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // Define the size of your cell here
        return CGSize(width: 160, height: 220) // example size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // example spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // example spacing
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            performSegue(withIdentifier: "toProductDetail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toProductDetail", let destinationVC = segue.destination as? ProductDetailViewController {
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                // Assuming you have a data source array called 'products'
//                let selectedProduct = products[indexPath.row]
//                destinationVC.product = selectedProduct
            }
        }
    }

    
}




