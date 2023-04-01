//
//  AuthUser.swift
//  demoP
//
//  Created by 200OK-IOS5 on 31/03/23.
//

import Foundation

var authUser: AuthUser?

class AuthUser {
    private var authKey = "AuthUserInfo"
    
    var userName:String?
    var userEmail:String?
    
    init() {
        if let json = UserDefaults.standard.value(forKey: authKey) as? Json {
            userName = json["name"]  as? String ?? ""
            userEmail = json["email"]  as? String ?? ""
        }
    }
    
    init(userName:String, userEmail:String){
        self.userName = userName
        self.userEmail = userEmail
        UserDefaults.standard.set(["name": userName,"email": userEmail], forKey: authKey)
        UserDefaults.standard.synchronize()
    }
    
    func logout() {
        UserDefaults.standard.removeObject(forKey: authKey)
        UserDefaults.standard.synchronize()
    }
}
