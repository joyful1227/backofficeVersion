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
    
    var order: Ordermain?                    //接上一頁傳來的物件
    var orderdetails = [Orderdetail]()       //接回傳的明細
    var accounts: UserAccount?               //接回傳的用戶物件
    var requestParam = [String: String]()     //請求訂單明細
    var requestAccount = [String: String]()  //請求會員資料
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountImage.layer.cornerRadius = accountImage.frame.width/2
        
        
        if let ordermain = order {
            let orderid = ordermain.order_id
            accountidLabel.text = "會員編號：\(order!.orderaccount_id ?? 0)"
            totalPriceLabel.text = "訂單總金額：\(order!.totalprice ?? 0)"
            
            
            
            //用訂單編號取明細
            requestParam["action"] = "getAllorderdetail"
            requestParam["orderid"] = "\(orderid!)"
            
            showproducts(requestParam, type: Orderdetail.self) { (orderdetails) in
                if orderdetails != nil {
                    if orderdetails!.isEmpty {
                        print("orderdetail is empty")
                    }else {                                 //確定回傳的內detail陣列裡面有明細[明細1,明細2,明細3]
                        self.orderdetails = orderdetails!
                        DispatchQueue.main.async {
                            self.detailTableView.reloadData()
                        }
                    }
                }
            }
            
            //用會員編號取照片
            requestAccount["action"] = "useSNgetaccount"
            requestAccount["snaccountid"] = String(order!.orderaccount_id!)
            //print("phone\(requestAccount)")
        
            showproducts(requestAccount, type: UserAccount.self) { (userAccounts) in
                if userAccounts != nil { //SVR有回傳
                    
                    if userAccounts!.isEmpty { //陣列無值
                        print("userAccounts is empty")
                    }else {                    //陣列有值
                        self.accounts = userAccounts!.first
                        DispatchQueue.main.async {
                          self.accountImage.image = UIImage(data: Data(base64Encoded: self.accounts!.photo!)!)
                            
                        }
                    }
                   
                }
            }
        
        
            
        }
    }
    

}


//Table View 處理
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
