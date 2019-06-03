//
//  RegisterViewController.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/1.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {

    
    
    @IBOutlet weak var inputAccountID: UITextField!
    @IBOutlet weak var inputPassword: UITextField!
    @IBOutlet weak var inputSecondPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    //取消鈕
    @IBAction func clickCancelButton(_ sender: Any) {
        let inAccountID = inputAccountID.text ?? ""
        let inPassword = inputPassword.text ?? ""
        let inSecondPassword = inputSecondPassword.text ?? ""
        
    
        if !inAccountID.isEmpty || !inPassword.isEmpty || !inSecondPassword.isEmpty{
            //提示已經填值，確定要返回？
          let alertController = UIAlertController(title: "尚未註冊完成", message: "返回上一頁", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "確定", style: .default) { (_) in
                self.dismiss(animated: true, completion: nil)
            }
            let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            
            present(alertController, animated: true, completion: nil)
            
        }else {
            //直接跳回登入頁
            dismiss(animated: true, completion: nil)
        }
        
    }
    
    

}
