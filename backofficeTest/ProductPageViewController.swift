//
//  ProductPageViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/11.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ProductPageViewController: UIViewController {
    
    var id: Int?
    var requestParam = [String:String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let id = id {
            
           requestParam["action"] = "getAlldetail"
           requestParam["orderid"] = String(id)
           showproducts(requestParam, type: Orderdetail.self) { (orderdetails) in
                //
            }
           
        }
        
    }
    

}
