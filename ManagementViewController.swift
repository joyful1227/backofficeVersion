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
        
        return cell
    }
    
    
}
