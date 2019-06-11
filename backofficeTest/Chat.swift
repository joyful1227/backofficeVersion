import UIKit
import Foundation
class Chat:Codable{
    var chat_id : Int?
    var user_id: Int?
    var product_id: Int?
    var content : String?
    var product_image: String?
    var chat_status : Int?
    public init(_ chat_id : Int?,_ user_id : Int,_ product_id:Int ,_ content : String?,_ product_image: String?,_ chat_status : Int?){
        self.chat_id = chat_id
        self.user_id = user_id
        self.product_id = product_id
        self.content = content
        self.product_image = product_image
        self.chat_status = chat_status
    }
    public init(_ user_id : Int,_ product_id:Int ,_ content : String?,_ chat_status : Int?){
        self.user_id = user_id
        self.product_id = product_id
        self.content = content
        self.chat_status = chat_status
    }
}
