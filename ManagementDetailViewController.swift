//
//  ManagementDetailViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/8.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ManagementDetailViewController: UIViewController {

    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var accountidLabel: UILabel!
    @IBOutlet weak var totalPriceLabel: UILabel!
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var order: Ordermain?
    var orderdetails = [Orderdetail]()
    var requestParam = [String:String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ordermain = order {
            let orderid = ordermain.order_id
            accountidLabel.text = "會員編號：\(order!.orderaccount_id ?? 0)"
            totalPriceLabel.text = "訂單總金額：\(order!.totalprice ?? 0)"
            //用會員編號取照片
            
            requestParam["action"] = "getAllorderdetail"
            requestParam["orderid"] = "\(orderid!)"
            
            showproducts(requestParam, type: Orderdetail.self) { (orderdetails) in
                if orderdetails != nil {
                    if orderdetails!.isEmpty {
                        print("orderdetail is empty")
                    }else {
                        self.orderdetails = orderdetails!
                        DispatchQueue.main.async {
                            self.detailTableView.reloadData()
                        }
                    }
                }
            }
        
            
        }
    }
    

}

extension ManagementDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("orderdetails.count=\(orderdetails.count)")
        return orderdetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = detailTableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as! ManagementDetailTableViewCell
        
        let orderdetail = orderdetails[indexPath.row]
        
        //cell.producdetailtName = orderdetail.orderproduct_id 用商品編號再去找
        cell.productdetailPrice.text = "商品金額：＄\(orderdetail.price!)"
        cell.productdetailAmount.text = "購買數量：\(orderdetail.amount!)個"
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
