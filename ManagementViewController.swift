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
    
    
    
    var segmentValue = "待出貨"
    var order = Order(cargoID: 1, name: "Joy", price: 500, image: "123454321", userID: 1, size: "S")
     //init(cargoID : Int,name: String, price: Int, image: String,userID : Int, size : String)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
        
        
        //物件要轉Json格式，才能變成字串（因為要放到Dictionary）
        let jsondata = try! JSONEncoder().encode(order)
        let jsonString = String(data: jsondata, encoding: String.Encoding.utf8)
       
        requestParam["order"] = jsonString
        
        showproducts(requestParam, type: String.self) { (items) in
            //..
        }
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //..取order id傳給下一頁 去取值
    }
    

}




extension ManagementViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    
    //區塊數
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //項目數
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    //資料內容顯示來源
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "orderCell") as! ManagementTableViewCell
           // cell = ManagementTableViewCell(style: .default, reuseIdentifier: "orderCell")
        
        
        cell.accessoryType = .disclosureIndicator   //" > "
        cell.orderButton.tag = indexPath.section+indexPath.row
        cell.orderButton.addTarget(self, action: #selector(orderButtonAction(sender:)), for: .touchUpInside)
        
        
        return cell
    }
    
    
    
    //cell 高度
    private func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    //選中
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    
}
