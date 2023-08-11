//
//  CartViewController.swift
//  MyShop
//
//  Created by Anup Kuriakose on 8/8/2023.
//

import UIKit
import Firebase

class CartViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var greetingLbl: UILabel!
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
        setupGreetingLbl()
    }
    
    private func setupGreetingLbl(){
        
        if let user = Auth.auth().currentUser {
           
            if let email = user.email {
                if let range = email.range(of: "@") {
                    var name = String(email[..<range.lowerBound])
                    name = name.prefix(1).capitalized + name.dropFirst()
                    greetingLbl.text = ("Hi \(name)")
                }
                
            }
        } else {
            
            greetingLbl.text = "Hi Guest"
        }
        
    }
      
      // Number of sections
      func numberOfSections(in tableView: UITableView) -> Int {
          return 1
      }
      
      // Number of rows in section
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          return 3 // Three cells
      }
      
      // Create the cell for each row
      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath)
          // Configure the cell as needed here
          return cell
      }
    


}
