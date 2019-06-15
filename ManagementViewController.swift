//
//  ManagementViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/5/31.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ManagementViewController: UIViewController {
    
    
    
    @IBOutlet weak var OrderStatusSegmented: UISegmentedControl!
    
    @IBOutlet weak var orderTableView: UITableView!
    
    
    var segmentTitle = "待出貨"
    var selectedSegmentIndex = 0
    
    var orders = [Ordermain]()
    var resultorders = [Ordermain]()
    var details = [Orderdetail]()
    var detail: Orderdetail?
    var orderid: Int?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        resultorders.removeAll()
        var requestParam = [String:String]()
        requestParam["action"] = "getAllorders"
        

        
        showproducts(requestParam, type: Ordermain.self) { (backOrders) in
            if backOrders != nil {
                self.orders  = backOrders!      // [ 訂單1, 訂單2, 訂單３ ] [orders[0].order_id= 1,7,8]
                //print(self.orders.first?.address ?? "")
                
                
                for order in self.orders {
                    if order.order_status == 0 {
                        self.resultorders.append(order)
                    }
                }
                DispatchQueue.main.async {
                    self.orderTableView.reloadData()
                }
                
                
                
                //要抓商品圖-------------------------------------------------------
                
                var requestdetail = [String:String]()
                requestdetail["action"] = "getOrderDetailAndProductName"
                
               
                
                for order in self.orders {
                    self.orderid = order.order_id!
                    requestdetail["orderid"] = "\(self.orderid!)"
                    
                    showproducts(requestdetail, type: Orderdetail.self) { (orderdetails) in
                        if orderdetails != nil {
                            if orderdetails!.isEmpty {
                                print("orderdetail is empty")
                            }else {                                 //確定回傳的內detail陣列裡面有明細[明細1,明細2,明細3]
                                self.details = orderdetails!
                                self.detail = self.details.first
                                
                                print("amount = \(self.detail?.product_Name)")
                                DispatchQueue.main.async {
                                   
                                    //cell.orderImage.image = UIImage(data: Data(base64Encoded: self.detail!.product_IMG!)!)
                                }
                            }
                        }
                    }
                    
                    
                }
                
                
                
                
        
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    
//頁籤轉換-----------------
    @IBAction func clickSegmented(_ sender: UISegmentedControl) {
        resultorders.removeAll()
        if sender.selectedSegmentIndex == 0 {
            segmentTitle = OrderStatusSegmented.titleForSegment(at: 0)! //待出貨
            selectedSegmentIndex = 0
            for order in self.orders {
                if order.order_status == 0 {
                    resultorders.append(order)
                }
            }
            
        }else if sender.selectedSegmentIndex == 1 {
            segmentTitle = OrderStatusSegmented.titleForSegment(at: 1)! //已出貨
            selectedSegmentIndex = 1
            for order in self.orders {
                if order.order_status == 1 || order.order_status == 2 {
                    resultorders.append(order)
                }
            }
            
        }else {
            print("segment value change fail ")
        }
        orderTableView.reloadData()
    }
    
//按出貨鈕,將狀態改成1
    @objc func orderButtonAction(sender: UIButton) -> Void {
        let row = sender.tag
        print("button tag = \(sender.tag)")
        let order = orders[row]
        
        
        var requestParam = [String:String]()
        requestParam["action"] = "changeToShip"
        requestParam["orderid"] = "\(order.order_id!)"
        
        showproducts(requestParam, type: Int.self) { (counts) in
            if counts != nil {
                if counts!.isEmpty {
                    print("counts = []")
                }else {
                    print("changeToShip is successful ,counts = [\(counts!.first!)]")
                    
                }
            }
         }
        
        //orderTableView.reloadData()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //..取order id傳給下一頁 去取值
        if let row = orderTableView.indexPathForSelectedRow?.row {
            let controller = segue.destination as! ManagementDetailViewController
            controller.order = resultorders[row]
        }
        
    }
    
}




extension ManagementViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    //區塊數
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //項目數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("order.count = \(orders.count)")
        return resultorders.count
    }
    
    //資料內容顯示來源
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! ManagementTableViewCell
           // cell = ManagementTableViewCell(style: .default, reuseIdentifier: "orderCell")
        
        let order = resultorders[indexPath.row]
        cell.orderidLabel.text = "訂單編號：\(order.order_id!)"
        cell.orderTotalPriceLabel.text = "訂單總金額：\(order.totalprice!)元"
        cell.orderCostPointLabel.text = "使用積分：\(order.costpoint!)  點"
        
        
        switch order.order_status {   // //0=待出貨   1=已出貨   2=已送達   3=客戶收到貨   4=已退貨
        
        case 0:
            cell.orderstatusLabel.text = "訂單狀態：待出貨"
        case 1:
            cell.orderstatusLabel.text = "訂單狀態：已出貨"
        case 2:
            cell.orderstatusLabel.text = "訂單狀態：已送達"
        case 3:
            cell.orderstatusLabel.text = "訂單狀態：客戶收到貨"
        case 4:
            cell.orderstatusLabel.text = "訂單狀態：已退貨"
        default:
            print("order_status  trans to text is fail")
        }
        
        
        cell.accessoryType = .disclosureIndicator   //" > " 圖案
        cell.orderButton.addTarget(self, action: #selector(orderButtonAction(sender:)), for: .touchUpInside)
        
        

        
        
        
        
        
        return cell
    }
    
    
    
    //cell 高度
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    //選中
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
    
    
}
