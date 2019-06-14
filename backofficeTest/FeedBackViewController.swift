//
//  FeedBackViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/14.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class FeedBackViewController: UIViewController {
    
    
    
    var product: Product?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
      
        if let product = product {
            
        }
        
    }
    



}


//table cell 內容--------------------------------------------------
extension FeedBackViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedBackCell", for: indexPath) as! FeedBackTableViewCell
        
        return cell
    }
    
    
    
}
