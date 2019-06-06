//
//  Globaldata.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/6.
//  Copyright © 2019 Joy. All rights reserved.
//

import Foundation

let user = UserAccount("sun", "123", "email")
let requestproduct = ["action" : "getAllproduct"]
let requestcategory = ["action" : "getAllcategory"]
var useraccount : UserAccount?
var shoppingcarts = [Shoppingcart]()
var products = [Product]()
var categorys = [Category]()
var mylikes = [Product]()
let url_server = URL(string: common_url + "ThunderServlet")



func showproducts<T:Codable,V:Codable>(_ requestParam: [String: V],type:T.Type,completionHandler: @escaping ([T]?)->()) {
    executeTask(url_server!, requestParam) { (data, response, error) in
        if error == nil {
            if data != nil {
                let decoder = JSONDecoder()
                decoder.dataDecodingStrategy = .deferredToData
                if let result = try? decoder.decode([T].self, from: data!) {
                    print(result)
                    completionHandler(result)
                }else{
                    print("error")
                }
            }
        } else {
            print(error!.localizedDescription)
        }
    }
}
