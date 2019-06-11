class ChatMessage: Codable {
    var type = ""
    var sender = ""
    var receiver = ""
    var message = ""
    
    init(type: String, sender: String, receiver: String, message: String) {
        self.type = type
        self.sender = sender
        self.receiver = receiver
        self.message = message
    }
}
