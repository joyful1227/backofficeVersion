//
//  Feedback.swift
//  backofficeTest
//
//  Created by Joy on 2019/6/9.
//  Copyright © 2019 Joy. All rights reserved.
//

import UIKit
import Foundation

class Feedback:Codable{
    var feedBack_id : Int?
    var fbfroduct_id: Int?
    var fbaccount_id: Int?
    var starcount : Int?
    var content : String?
    var fbimage: String?
    
    
    public init(_ feedBack_id : Int,_ fbfroduct_id:Int ,_ fbaccount_id: Int ,_ starcount : Int,_ content : String,_ fbimage: String){
        self.feedBack_id = feedBack_id
        self.fbfroduct_id = fbfroduct_id
        self.fbaccount_id = fbaccount_id
        self.starcount = starcount
        self.content = content
        self.fbimage = fbimage
    }
    
    
    
    public init(_ fbfroduct_id:Int ,_ fbaccount_id: Int ,_ starcount : Int,_ content : String,_ fbimage: String){
        self.fbfroduct_id = fbfroduct_id
        self.fbaccount_id = fbaccount_id
        self.starcount = starcount
        self.content = content
        self.fbimage = fbimage
    }
    
    public init(_ fbfroduct_id:Int ,_ fbaccount_id:Int ,_ starcount :Int,_ content :String){
        self.fbfroduct_id = fbfroduct_id
        self.fbaccount_id = fbaccount_id
        self.starcount = starcount
        self.content = content
    }
    
    
    
}
