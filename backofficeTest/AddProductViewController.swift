//
//  AddProductViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/6.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {
    
    @IBOutlet weak var inputProductName: UITextField!
    @IBOutlet weak var inputProductPrice: UITextField!
    @IBOutlet weak var productIMG1: UIButton!
    @IBOutlet weak var productIMGbk: UIImageView!
    var image: UIImage?

    
    var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func clickProductIMG1(_ sender: Any) {
      let alertController =  UIAlertController(title: "新增商品從", message: nil, preferredStyle: .actionSheet)
      
        let options = ["相機", "照片"]
        for option in options {
            let action = UIAlertAction(title: option, style: .default) { (action) in
                //print(action.title!)
                
                switch (action.title) {
                case "相機":
                    self.showCamera()
                case "照片":
                    self.showAlbum()
                default:
                    print("select on action sheet fail")
                }
                
            }
            alertController.addAction(action)
        }
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        
        present(alertController, animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func clickSubmit(_ sender: Any) {
                                                //如果是nil給空字串，不是nil剪掉空白、換行
        let inproductName = inputProductName.text == nil ? "" : inputProductName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inproductPrice = inputProductPrice.text == nil ? "" : inputProductPrice.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var isValid = true
        var requestParam = [String: String]()
        requestParam["action"] = "insertProduct"
        requestParam["product"] = "123"
        
        
        //沒有上傳照片的話
        if image == nil {
            //textfield =
            isValid = false
        }
        
        //name是空字串
        if inproductName.isEmpty {
            //textfield =
            isValid = false
        }
        
        
        //price不是整數型態
        if Int(inproductPrice) == nil {
            //textfield =
            isValid = false
        }
        
                
            
        if isValid == true {
            
            let base64image = image?.jpegData(compressionQuality: 1.0)?.base64EncodedString()
            let product = Product(0, inproductName, base64image!, Int(inproductPrice)!)
            
        }
                
        
          
           
//
//            showproducts(requestParam, type: Product.self) { (items) in
//                if items != nil {
//                  self.products = items!
//                }
//              }
//            }else {
//                 //價格欄位未輸入數字
//                 print(" Int(inproductPrice) fail")
//
//            }
//        }else {
//             //使用沒有上傳照片
//        }
        
    
    
//    func addProduct() -> (Void) {
//        <#function body#>
//    }
    
    
    }
    
}




extension AddProductViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //相機
    func showCamera()  {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .camera
        
        present(cameraPicker, animated: true, completion: nil)
        
    }
    
    //相簿
    func showAlbum() {
       let albumPicker = UIImagePickerController()
       albumPicker.delegate = self
       albumPicker.sourceType = .photoLibrary
        
       present(albumPicker, animated: true, completion: nil)
    }
    
    //選擇照片後
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let photo = info[.originalImage] as? UIImage
        image = photo
        productIMG1.setImage(photo, for: .normal)
        productIMG1.imageView?.contentMode = .scaleAspectFit
        
        dismiss(animated: true, completion: nil)
        //productIMGbk.image = nil
    }
    
    //取消
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}
