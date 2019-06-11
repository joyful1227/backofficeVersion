class StateMessage: Codable {
    var type = ""
    var user = ""
    var users = Set<String>()
    
    init(type: String, user: String, users: Set<String>) {
        self.type = type
        self.user = user
        self.users = users
    }
}
