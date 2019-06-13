//
//  ProductModifyViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/13.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class ProductModifyViewController: UIViewController {


    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var productNameTextField: UITextField!
    @IBOutlet weak var productSizeTextField: UITextField!
    @IBOutlet weak var productPriceTextField: UITextField!
    @IBOutlet weak var imageButton: UIButton!
    
    
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    
    var image: UIImage?
    var product: Product?
    var requestParam = [String: String]()
    var picker = UIPickerView()
    
    
    var backcategory = Array<Category>()   //接收回傳分類陣列
    var backcategoryName = Array<String>() //接收回傳分類名稱
    var dataforSize = ["S","M","L"]
    
    var selectedCategory_id = 0
    var cateid = 0
    var productid = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let product = product {
           print("product.category_name = \(product.category_name!)")
           productid = product.product_id!
           productNameTextField.text = product.product_name!
           productPriceTextField.text = "\(product.price ?? 0)"
           categoryTextField.text = product.category_name
           productSizeTextField.text = product.size
           
           imageButton.setImage(UIImage(data: Data(base64Encoded: self.product!.product_image!)!), for: .normal)
          
            
            let requestcategory = ["action" : "getAllcategory"]
            showproducts(requestcategory, type: Category.self) { (categories) in
                if categories != nil {
                    self.backcategory = categories!

                    
//                    for i in self.backcategory {
//                        if i.category_name == product.category_name {
//                            self.selectedCategory_id = i.category_id! //找到舊id
//                        }
//                    }
                    
                    
                    DispatchQueue.main.async {
                        self.picker.reloadAllComponents()
                        //self.categoryTextField.text = self.backcategory.first?.category_name
                    }
                }
            }

        }
        
        
        
        
        //鍵盤
        let tapScrollView: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyBoard))
        self.view.addGestureRecognizer(tapScrollView) // to Replace func "TouchesBegan"
        
        //PickerView
        picker.delegate = self
        picker.dataSource = self
        categoryTextField.inputView = picker //讓tf的輸入方式改為PickerView
        //sizeTextField.inputView = picker     //讓tf的輸入方式改為PickerView
        //categoryTextField.text = backcategoryName.first
        //sizeTextField.text = dataforSize.first
        print("backcategoryName = \(backcategoryName.count)")

        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap)
            
        
        
        
        
        
    }
    
    
    //商品照片
    @IBAction func clickImageButton(_ sender: UIButton) {
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
        let inproductName = productNameTextField.text == nil ? "" : productNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inproductPrice = productPriceTextField.text == nil ? "" : productPriceTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var isValid = true
        var requestParam = [String: String]()
        
        
        
        //name是空字串
        if inproductName.isEmpty {
            //suggestForProductName.text = "請輸入商品名稱！"
            isValid = false
        }
        
        
        //price不是整數型態
        if Int(inproductPrice) == nil || Int(inproductPrice) == 0 {
            //suggestForPrice.text = "請輸入商品金額!"
            isValid = false
        }
        
        if isValid == true {
              image = self.imageButton.image(for: .normal)
          let base64image = image?.jpegData(compressionQuality: 1.0)?.base64EncodedString()
            
            
            //透過名字查id
            //[1,4,7]
            //[上衣,下衣,褲子]
            
          for i in backcategory {
              if i.category_name == categoryTextField.text {
                  cateid = i.category_id ?? 0
              }
          }
            
          let product = Product(productid, inproductName, base64image!, productSizeTextField.text!, Int(inproductPrice)!, cateid, 1)
            
          //物件要轉Json格式，才能變成字串（因為要放到Dictionary）
          let productJson = try! JSONEncoder().encode(product)
          let productString = String(data: productJson, encoding: String.Encoding.utf8)
          
          requestParam["action"] = "updateProduct"
          requestParam["product"] = productString
          
          activityIndicatorView.center = view.center
          activityIndicatorView.startAnimating()
            
            showproducts(requestParam, type: Int.self) { (idArray) in
                
                DispatchQueue.main.async {
                    self.activityIndicatorView.removeFromSuperview()
                }
                if idArray != nil {
                    let alertController = UIAlertController(title: nil, message: "修改成功", preferredStyle: .alert)
                    self.present(alertController, animated: false, completion:nil)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
                        self.presentedViewController?.dismiss(animated: false
                            , completion:nil)
                        self.navigationController?.popViewController(animated: false)
                }
            
           }
            
            
                
            }
            
        
        
       }
    
    }
    

}

//鍵盤處理
extension ProductModifyViewController:  UITextFieldDelegate{

    
    @objc func dismissKeyBoard() {
        self.view.endEditing(true)
    }
    
    
    //按鍵盤上的return鍵可收起鍵盤
    //1.遵從UITextFieldDelegate 2.且tf需control drag 與view controller連結delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  //要求他響應我們的Responder
        return true
    }
    
}


//Camera、Album
extension ProductModifyViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
        if let photo = info[.originalImage] as? UIImage {
            image = photo
            //UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
            imageButton.setImage(photo, for: .normal)
            imageButton.imageView?.contentMode = .scaleAspectFit
        }
        dismiss(animated: true, completion: nil)
    }
    
    //取消
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}



//PickerView for category
extension ProductModifyViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    //當手勢觸發的時候，關閉編輯畫面
    @objc func closeKeyboard(){
        self.view.endEditing(true)
    }
    
    //有幾個區塊
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    //裡面有幾個項目
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if categoryTextField.isFirstResponder {
            return backcategory.count
        }else { //sizeTextField.isFirstResponder
            return dataforSize.count
        }
    }
    
    //設定每列要顯示的內容
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if categoryTextField.isFirstResponder {
            return backcategory[row].category_name
        }else { //sizeTextField.isFirstResponder
            return dataforSize[row]
        }
    }
    
    //選到那列要做的事情
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if categoryTextField.isFirstResponder {
            categoryTextField.text = backcategory[row].category_name
        }else { //sizeTextField.isFirstResponder
            productSizeTextField.text = dataforSize[row]
        }
    }
}
