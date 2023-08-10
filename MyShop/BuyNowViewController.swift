//
//  BuyNowViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 9/8/2023.
//

import UIKit

class BuyNowViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
          super.viewDidLoad()
          
          // Register the CartItemCell.xib
          let nib = UINib(nibName: "CartItemCell", bundle: nil)
          tableView.register(nib, forCellReuseIdentifier: "CartItemCell")
          
          // Set the delegate and dataSource for the tableView
          tableView.delegate = self
          tableView.dataSource = self
        
        // Remove the lines between cells
            tableView.separatorStyle = .none
      }
      
      // Number of sections
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      // Number of rows in section
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 1 // Three cells
      }
      
      // Create the cell for each row
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
          // Configure the cell as needed here
          return cell
      }
    


}
