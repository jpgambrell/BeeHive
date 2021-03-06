

struct User {
    var userName : String?
    var firstName : String?
    var lastName : String?
    var roleId : String?
    var departmentId : String?
    var supervisorId : String?
    
    init() {}
    
    init(userName: String?, firstName : String?, lastName : String?, roleId : String?, departmentId : String?, supervisorId : String?){
        self.userName = userName
        self.firstName = firstName
        self.lastName = lastName
        self.roleId = roleId
        self.departmentId = departmentId
        self.supervisorId = supervisorId
    }
    
    func asDictionary() -> [String: String] {
        return [ "username" : self.userName ?? "",
            "firstname" : self.firstName ?? "",
            "lastname" : self.lastName ?? "",
            "roleid" : self.roleId ?? "",
            "departmentid" : self.departmentId ?? "",
            "supervisorid" : self.supervisorId ?? ""]
    }
}
