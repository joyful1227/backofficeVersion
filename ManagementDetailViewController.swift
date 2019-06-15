//
//  ManagementDetailViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/8.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ManagementDetailViewController: UIViewController {

    @IBOutlet weak var accountImage: UIImageView!  //帳戶照片
    @IBOutlet weak var accountidLabel: UILabel!    //會員帳號
    @IBOutlet weak var orderReceiver: UILabel!     //該訂單收件者
    @IBOutlet weak var orderPhone: UILabel!        //該訂單連絡電話號碼
    @IBOutlet weak var orderAddress: UILabel!      //該訂單收件地址
    
    
    
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var order: Ordermain?                     //接上一頁傳來的物件
    var orderdetails = [Orderdetail]()        //接回傳的明細
    var accounts: UserAccount?                //接回傳的用戶物件
    var requestParam = [String: String]()     //請求訂單明細
    var requestAccount = [String: String]()   //請求會員資料
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountImage.layer.cornerRadius = accountImage.frame.width/2
        
        
        if let ordermain = order {
            let orderid = ordermain.order_id
            navigationItem.title = "訂單編號：\(orderid!)"
            //totalPriceLabel.text = "訂單總金額：\(order!.totalprice ?? 0)"
            //orderUsePoint.text = "使用積分：\(order!.costpoint ?? 0)點"
            orderReceiver.text = "收件人：\(order!.receiver!)"
            orderPhone.text = "電話號碼：\(order!.phone!)"
            orderAddress.text = "地址：\(order!.address!)"
            
            
            
            //用訂單編號取明細
            requestParam["action"] = "getOrderDetailAndProductName"
            requestParam["orderid"] = "\(orderid!)"
            
            showproducts(requestParam, type: Orderdetail.self) { (orderdetails) in
                if orderdetails != nil {
                    if orderdetails!.isEmpty {
                        print("orderdetail is empty")
                    }else {                                 //確定回傳的內detail陣列裡面有明細[明細1,明細2,明細3]
                        self.orderdetails = orderdetails!
                        DispatchQueue.main.async {
                            self.detailTableView.reloadData()
                            print("product_Name = \(orderdetails?.first?.product_Name)")
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
                            self.accountidLabel.text = "會員帳號：\(self.accounts!.account_id!)"

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
        cell.productdetailImage.image = UIImage(data: Data(base64Encoded: orderdetail.product_IMG ?? "")!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
