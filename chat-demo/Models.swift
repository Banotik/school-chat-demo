//
//  Models.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import Foundation

class User{
    // user name
    let username: String
    // user id
    let uuid = UUID().uuidString
    
    init(username: String){
        self.username = username 
    }
    
}

class Student: User{
    
}

class Teacher: User{
    
}

class GuestStudent: Student{

}

class GuestTeacher: Teacher{
    
}

final class Auth{

    var user: User?
    
    static let auth = Auth()
    
    private init(){ }
    
    func signUp(guest: User){
        self.user = guest
    }
}


/*
 * We can package more data here
 * timestamp, time read, etc
 */
struct ChatMessageModel{
    
    let message: String
    var userName: String?
    let uuid: String
    
    
    
    init(dict: [String: Any]) {
       
        self.uuid = dict["uuid"] as! String 
        self.message = dict["message"] as! String
        
        if let userName = dict["userName"] as? String{
            self.userName = userName
        }
    }
    
    init(uuid: String, message: String){
        self.uuid = uuid
        self.message = message
        
    }
    
    func toJSON()->[String: Any]{
        var dict = [String: Any]()
        
        dict["uuid"] = uuid
        dict["message"] = message
        dict["userName"] = userName
        
        return dict
    }
    
}

