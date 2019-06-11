
import Starscream
import UIKit
import Foundation
var socket: WebSocket!
var userids = [String]()
var showchats = [Chat]()
var allshowchats = [Chat]()
class ChatViewController: UIViewController ,UITableViewDataSource , UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showchats.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatTableViewCell", for: indexPath) as! ChatTableViewCell
        let showchat = showchats[indexPath.row]
        cell.lbuserid.text = "會員編號：\(showchat.user_id!)"
        cell.lbproductid.text = "商品編號：\(showchat.product_id!)"
        return cell
    }
    var user = "admins"
    @IBOutlet weak var tableview: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        

        socket = WebSocket(url: URL(string: chatcommon_url + "\(user)")!)
        
        socket.connect()
    }
    override func viewWillAppear(_ animated: Bool) {
        addSocketCallBacks()
        let requestselectchat = ["action":"selectallchat"]
        showproducts(requestselectchat,type: Chat.self){(items) in
            
            if items != nil{
                showchats.removeAll()
                allshowchats.removeAll()
                chats = items!
                for chat in chats{
                    for (index,showchat) in allshowchats.enumerated(){
                        if chat.product_id == showchat.product_id && chat.user_id == showchat.user_id {
                            allshowchats.remove(at: index)
                        }
                    }
                    allshowchats.append(chat)
                    
                }
                for showchat in allshowchats{
                    if showchat.chat_status == 0{
                        showchats.append(showchat)
                    }
                }
                DispatchQueue.main.async{
                    self.tableview.reloadData()
                }
            }
        }
    }
    func addSocketCallBacks() {
        socket.onConnect = {
            print("websocket is connected")
        }
        
        socket.onDisconnect = { (error: Error?) in
            print("websocket is disconnected: \(error?.localizedDescription ?? "")")
        }
        
        socket.onText = { (text: String) in
            
            let requestselectchat = ["action":"selectallchat"]
            showproducts(requestselectchat,type: Chat.self){(items) in
                if items != nil{
                    chats = items!
                    showchats.removeAll()
                    allshowchats.removeAll()
                    for chat in chats{
                        for (index,showchat) in allshowchats.enumerated(){
                            if chat.product_id == showchat.product_id && chat.user_id == showchat.user_id {
                                allshowchats.remove(at: index)
                            }
                        }
                        allshowchats.append(chat)
                        
                    }
                    for showchat in allshowchats{
                        if showchat.chat_status == 0{
                            showchats.append(showchat)
                        }
                    }
                    DispatchQueue.main.async{
                        self.tableview.reloadData()
                    }
                }
            }
//            if let chatMessage = try? JSONDecoder().decode(ChatMessage.self, from: text.data(using: .utf8)!) {
//            }
        }
        
        socket.onData = { (data: Data) in
            print(" got some data: \(data.count)")
        }
    }
    @IBAction func clicksegmented(_ sender: UISegmentedControl) {
        let selectedSegmentIndex = sender.selectedSegmentIndex
        
        switch selectedSegmentIndex {
        case 0:
            
            showchats.removeAll()
            for showchat in allshowchats{
                if showchat.chat_status == 0{
                    showchats.append(showchat)
                }
            }
        case 1:
            showchats.removeAll()
            for showchat in allshowchats{
                if showchat.chat_status == 1{
                    showchats.append(showchat)
                }
            }
            
        default:
            break
        }
        tableview.reloadData()
    }

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indexpath = tableview.indexPathForSelectedRow
        let showchat = showchats[indexpath!.row]
        
        let chatmessagevc = segue.destination as! ChatmessageVC
        for product in products{
            if product.product_id == showchat.product_id {
                chatmessagevc.product = product
                chatmessagevc.userid = showchat.user_id!
                break
            }
        }
    }
    

}
