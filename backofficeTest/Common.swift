//
//  Common.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/6.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation
import UIKit

// 實機
// let common_url = "http://192.168.0.101:8080/Book_MySQL_Web/"


// 模擬器
let common_url = "http://127.0.0.1:8080/Thunder_Web/"

/**
 向server發出請求，並在取得回應後執行特定程式
 - parameters:
 - url_server: 網址
 - requestParam: 請求參數
 - completionHandler: 取得server回應後執行的特定程式
 */

func executeTask<T:Codable>(_ url_server: URL, _ requestParam: [String: T], completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
    // 將輸出資料列印出來除錯用
    print("output: \(requestParam)")
    
    let jsonData = try! JSONEncoder().encode(requestParam)
    var request = URLRequest(url: url_server)
    request.httpMethod = "POST"
    request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData
    request.httpBody = jsonData
    let sessionData = URLSession.shared
    let task = sessionData.dataTask(with: request, completionHandler: completionHandler)
    task.resume()
}

func showSimpleAlert(message: String, viewController: UIViewController) {
    let alertController = UIAlertController(title: "", message: message, preferredStyle: .alert)
    let cancel = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(cancel)
    /* 呼叫present()才會跳出Alert Controller */
    viewController.present(alertController, animated: true, completion:nil)
}
