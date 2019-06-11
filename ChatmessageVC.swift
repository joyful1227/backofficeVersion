import Starscream
import UIKit
import Foundation

class ChatmessageVC: UIViewController {

    @IBOutlet weak var lbuserid: UILabel!
    @IBOutlet weak var ivproductimage: UIImageView!
    @IBOutlet weak var lbproductid: UILabel!
    @IBOutlet weak var lbmessage: UILabel!
    @IBOutlet weak var tfmessage: UITextField!
    var product : Product!
    var userid : Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbmessage.text = ""
        addSocketCallBacks()
        for chat in chats{
            if chat.product_id == product.product_id{
                if chat.user_id == userid! && chat.chat_status == 0{
                    lbmessage.text! += "會員編號\(userid!):\(chat.content!)\n"
                }else if chat.user_id == userid! && chat.chat_status == 1{
                    lbmessage.text! += "\(chat.content!)\n"
                }
                
            }
        }
        lbuserid.text = "會員編號：\(userid!)"
        lbproductid.text = "商品編號：\(product.product_id!)"
        ivproductimage.image = UIImage(data: Data(base64Encoded: product.product_image!)!)
    }
    func addSocketCallBacks() {
        
        socket.onText = { (text: String) in
            
            if let chatMessage = try? JSONDecoder().decode(ChatMessage.self, from: text.data(using: .utf8)!) {
                let sender = chatMessage.sender
                // 接收到聊天訊息，若發送者與目前聊天對象相同，就將訊息顯示在TextView
                if sender == "\(self.userid!)" {
                    let message = "會員編號\(sender): \(chatMessage.message)"
                    self.lbmessage.text! += message+"\n"
                }
            }
            
            
        }
        
        socket.onData = { (data: Data) in
            print(" got some data: \(data.count)")
        }
    }

    @IBAction func clicksubmit(_ sender: UIButton) {
        lbmessage.text! += tfmessage.text!+"\n"
        
        let message = tfmessage.text!
        // 訊息不可為nil或""
        let chat = Chat(userid, product.product_id!, message,1)
        let requestintertchat = ["action" : "intertchat","chat":String(data: try! JSONEncoder().encode(chat), encoding: String.Encoding.utf8)]
        showproducts(requestintertchat,type: Chat.self){(items) in
        }
        if message == "" || message.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        let chatMessage = ChatMessage(type: "ch", sender: "admins", receiver: "\(userid!)", message: message)
        
        if let jsonData = try? JSONEncoder().encode(chatMessage) {
            let text = String(data: jsonData, encoding: .utf8)
            socket.write(string: text!)
            // debug用
            print(" send messages: \(text!)")
            
            // 將欲傳送訊息顯示在text view上
            
            // 將輸入的訊息清空
            tfmessage.text = nil
        }
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
