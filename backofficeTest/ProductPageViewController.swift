//
//  ProductPageViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/11.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ProductPageViewController: UIViewController {
    
    
    @IBOutlet weak var productImage: UIImageView!
    
    @IBOutlet weak var productCategoryName: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productSize: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productStatus: UILabel!
    
    var id: Int?
    var productStatusText = ""
    var requestParam = [String:String]()
    var productArray = [Product]()
    var product: Product?
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let id = id {
            
            requestParam["action"] = "getProductDetail"
            requestParam["productid"] = String(id)
            showproducts(requestParam, type: Product.self) { (productDetail) in   //[物件]
                if productDetail != nil {
                    self.productArray  = productDetail!
                    if self.productArray.count > 0 {     //確認array有東西
                        self.product = self.productArray.first
                        if self.product?.product_status == 0 {
                            self.productStatusText = "待上架"
                        }else if self.product?.product_status == 1 {
                            self.productStatusText = "已上架"
                        }else {
                            print("productStatusText error")
                        }
                        
                        DispatchQueue.main.async {
                            self.navigationItem.title = "商品編號：\(self.product!.product_id ?? 0)"
                            self.productCategoryName.text = "商品分類： \(self.product!.category_name ?? "")"
                            self.productName.text = "商品名稱： \(self.product!.product_name ?? "")"
                            self.productPrice.text = "商品價格：$\(self.product!.price ?? 0)"
                            self.productSize.text = "商品尺寸：\(self.product?.size ?? "")"
                            self.productImage.image = UIImage(data: Data(base64Encoded: self.product!.product_image!)!)
                            self.productStatus.text = "商品狀態：\(self.productStatusText)"
                        }
                        
                        
                    }
                    
                    
                }
                
            }
            
            
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //print(id)
        //print("product page")
//        if let id = id {
//            
//           requestParam["action"] = "getProductDetail"
//           requestParam["productid"] = String(id)
//           showproducts(requestParam, type: Product.self) { (productDetail) in   //[物件]
//            if productDetail != nil {
//               self.productArray  = productDetail!
//                if self.productArray.count > 0 {     //確認array有東西
//                    self.product = self.productArray.first
//                    if self.product?.product_status == 0 {
//                        self.productStatusText = "待上架"
//                    }else if self.product?.product_status == 1 {
//                        self.productStatusText = "已上架"
//                    }else {
//                        print("productStatusText error")
//                    }
//                    
//                    DispatchQueue.main.async {
//                        self.navigationItem.title = "商品編號：\(self.product!.product_id ?? 0)"
//                        self.productCategoryName.text = "商品分類： \(self.product!.category_name ?? "")"
//                        self.productName.text = "商品名稱： \(self.product!.product_name ?? "")"
//                        self.productPrice.text = "商品價格：$\(self.product!.price ?? 0)"
//                        self.productSize.text = "商品尺寸：\(self.product?.size ?? "")"
//                        self.productImage.image = UIImage(data: Data(base64Encoded: self.product!.product_image!)!)
//                        self.productStatus.text = "商品狀態：\(self.productStatusText)"
//                    }
//                    
//                    
//                }
//                
//                
//            }
//           
//        }
//        
//        
//    }
    

  }
    
    @IBAction func clickDelete(_ sender: UIButton) {
        let productid = product?.product_id
        let productidString = String(productid!)
        var requestParam = [String:String]()
        requestParam["action"] = "deleteProduct"
        requestParam["productid"] = productidString
        
        showproducts(requestParam, type: Int.self) { (idArray) in
            if idArray != nil {
                //..
                DispatchQueue.main.async {
                    self.dismiss(animated: true, completion: nil)
                }
                
            }
        }
        
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "goToProductModify" {
           let controller = segue.destination as! ProductModifyViewController
           controller.product = product
        }else if segue.identifier == "goToProductModify" {
            let controller = segue.destination as! FeedBackViewController
            controller.product = product
        }else {
            print("product page prepare fail")
        }
    }
    
}
