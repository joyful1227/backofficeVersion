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
    
    
    var segmentValue = "待出貨"
    var orders = [Ordermain]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        var requestParam = [String:String]()
        requestParam["action"] = "getAllorders"
        showproducts(requestParam, type: Ordermain.self) { (backOrders) in
            if backOrders != nil {
                self.orders  = backOrders!      // [ 訂單1, 訂單2, 訂單３ ]
                  //print(self.orders.first?.address ?? "")
                DispatchQueue.main.async {
                   self.orderTableView.reloadData()
                }
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clickSegmented(_ sender: UISegmentedControl) {
        
        if sender.selectedSegmentIndex == 0 {
           segmentValue = OrderStatusSegmented.titleForSegment(at: 0)!
                         // print("segmentValue = " + segmentValue)
        }else if sender.selectedSegmentIndex == 1 {
           segmentValue = OrderStatusSegmented.titleForSegment(at: 1)!
                        // print("segmentValue = " + segmentValue)
        }else {
              print("segment value change fail ")
        }
    }
    
    
    @objc func orderButtonAction(sender: UIButton) -> Void {
        print("button tag = \(sender.tag)")
        
        var requestParam = [String:String]()
        requestParam["action"] = "changeToShip"
        //requestParam["orderid"] =
        
        //物件要轉Json格式，才能變成字串（因為要放到Dictionary）
        //let jsondata = try! JSONEncoder().encode(order)
       // let jsonString = String(data: jsondata, encoding: String.Encoding.utf8)
       
       // requestParam["order"] = jsonString
        
        //showproducts(requestParam, type: String.self) { (items) in
            //..
       // }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //..取order id傳給下一頁 去取值
        if let row = orderTableView.indexPathForSelectedRow?.row {
           let controller = segue.destination as! ManagementDetailViewController
           controller.order = orders[row]
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
        return orders.count
    }
    
    //資料內容顯示來源
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! ManagementTableViewCell
           // cell = ManagementTableViewCell(style: .default, reuseIdentifier: "orderCell")
        
        let order = orders[indexPath.row]
        cell.orderidLabel.text = "訂單編號：\(order.order_id!)"
        cell.orderTotalPriceLabel.text = "訂單總金額：\(order.totalprice!)元"
        
        
        
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
