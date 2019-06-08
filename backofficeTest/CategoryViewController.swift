//
//  CategoryViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/5/30.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
//        customerButton.setButtonTitles(buttonTitles: ["女裝","男裝","配件"])
//        customerButton.selectorViewColor = .orange
//        customerButton.selectorTextColor = .orange
        
        
        
    }

}

extension CategoryViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cateCell", for: indexPath) as! CategoryTableViewCell
        return cell
    }
    
}
