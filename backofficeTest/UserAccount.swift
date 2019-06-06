//
//  UserAccount.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/5.
//  Copyright © 2019 Joy. All rights reserved.
//
import UIKit
import Foundation

class UserAccount:Codable{
    var id: Int?
    var account_id: String?
    var password : String?
    var email :String?
    var phone :String?
    var nickname :String?
    var photo :String?
    var point :Int?
    var account_status :Int?
    public init(_ account_id:String , _ password : String, _ email : String){
        self.account_id = account_id
        self.password = password
        self.email = email
    }
    public init(_ account_id:String , _ password : String, _ email : String, _ photo : String){
        self.account_id = account_id
        self.password = password
        self.email = email
        self.photo = photo
    }
    
}
