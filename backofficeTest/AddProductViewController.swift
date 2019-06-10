//
//  AddProductViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/6.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class AddProductViewController: UIViewController {
    
    
    
    @IBOutlet weak var suggestForImage: UILabel!
    @IBOutlet weak var suggestForProductName: UILabel!
    @IBOutlet weak var suggestForPrice: UILabel!
    
    
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var sizeTextField: UITextField!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var inputProductName: UITextField!
    @IBOutlet weak var inputProductPrice: UITextField!
    @IBOutlet weak var productIMG1: UIButton!
    
    let activityIndicatorView = UIActivityIndicatorView(style: .gray)
    var image: UIImage?

    var backids = Array<Int>() //接收回傳的id陣列
    var products = [Product]() //商品做成物件
    var backcategory = Array<Category>()   //接收回傳分類陣列
    var backcategoryName = Array<String>() //接收回傳分類名稱
    
    
    
    var picker = UIPickerView()
    //var dataForCategory = ["1","2","3"]
    var dataforSize = ["S","M","L"]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        suggestForImage.text = ""
        suggestForPrice.text = ""
        suggestForProductName.text = ""
        
        let requestcategory = ["action" : "getAllcategory"]
        showproducts(requestcategory, type: Category.self) { (categories) in
            if categories != nil {
                self.backcategory = categories!
                //print(categories as! Category)
                print("backcategory.count = ")
                print(self.backcategory.count)
                DispatchQueue.main.async {
                    self.picker.reloadAllComponents()
                    self.categoryTextField.text = self.backcategory.first?.category_name
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
        sizeTextField.inputView = picker     //讓tf的輸入方式改為PickerView
        categoryTextField.text = backcategoryName.first
        sizeTextField.text = dataforSize.first
        print("backcategoryName = \(backcategoryName.count)")
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        self.view.addGestureRecognizer(tap)
        
    }
    
    //新增照片------------------------------------------------------------------------------------------
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
    
    
    
    
    //送出------------------------------------------------------------------------------------------
    @IBAction func clickSubmit(_ sender: Any) {
                                                //如果是nil給空字串，不是nil剪掉空白、換行
        let inproductName = inputProductName.text == nil ? "" : inputProductName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let inproductPrice = inputProductPrice.text == nil ? "" : inputProductPrice.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var isValid = true
        var requestParam = [String: String]()
        requestParam["action"] = "insertProduct"

        
        
        //沒有上傳照片的話
        if image == nil {
            suggestForImage.text = "請上傳商品照片！"
            isValid = false
        }
        
        //name是空字串
        if inproductName.isEmpty {
            suggestForProductName.text = "請輸入商品名稱！"
            isValid = false
        }
        
        
        //price不是整數型態
        if Int(inproductPrice) == nil {
            suggestForPrice.text = "請輸入商品金額!"
            isValid = false
        }
        
                
        //當所有資料合法時---------
        if isValid == true {
            let base64image = image?.jpegData(compressionQuality: 1.0)?.base64EncodedString()
            let product = Product(0, inproductName, base64image!, Int(inproductPrice)!, 1, 1)
            
            
            //public init(_ product_id: Int, _ product_name: String, _ product_image: String, _ price: Int, _ category_id: Int, _ product_status: Int)
            
            //物件要轉Json格式，才能變成字串（因為要放到Dictionary）
            let productJson = try! JSONEncoder().encode(product)
            let productString = String(data: productJson, encoding: String.Encoding.utf8)
            requestParam["product"] = productString
            
            
            
            activityIndicatorView.center = view.center
            activityIndicatorView.startAnimating()
            showproducts(requestParam, type: Int.self) { (idArray) in
                
                DispatchQueue.main.async {
                    self.activityIndicatorView.removeFromSuperview()
                }
                
                
                if idArray != nil {
                   
                    self.backids = idArray!
                    print("backids count = \(self.backids.count)")
                    if let id = self.backids.first {
                         print("id = \(id)")
                       
                        let alertController = UIAlertController(title: "商品已成功上架", message: nil, preferredStyle: .alert)
                        let okAlert = UIAlertAction(title: "確定", style: .default) { (action) in
                            self.goToProductPage(id)
                        }
                        alertController.addAction(okAlert)
                    }
                }
            }
        }
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let productPageController = storyboard?.instantiateViewController(withIdentifier: "ProductPage") as? ProductPageViewController {
//            //productPageController.id =
//            present(productPageController, animated: true, completion: nil)
//        }
//
//    }
    
    func goToProductPage(_ id: Int) {
        if let productPageController = tabBarController?.viewControllers?[0] as? ProductPageViewController{
            productPageController.id = id
            tabBarController?.selectedIndex = 0
        }
        
    }
    
}


//鍵盤處理
extension AddProductViewController:  UITextFieldDelegate{
    
//    //當點擊view任何一處鍵盤收起
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        //self.view.endEditing(true)
//        self.scrollView.endEditing(true)
//    }
    
    
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
        if let photo = info[.originalImage] as? UIImage {
          image = photo
         // UIImageWriteToSavedPhotosAlbum(photo, nil, nil, nil)
          productIMG1.setImage(photo, for: .normal)
          productIMG1.imageView?.contentMode = .scaleAspectFit
        }
        
        
        dismiss(animated: true, completion: nil)
        
    }
    
    //取消
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
}


//PickerView for category
extension AddProductViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
             sizeTextField.text = dataforSize[row]
        }
    }
}
