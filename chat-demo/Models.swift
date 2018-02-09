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


/*
 * We can package more data here
 * timestamp, time read, etc
 */
struct ChatMessageModel{
    
    let myMessage: Bool
    let message: String
    var userName: String?
    
    init(dict: [String: Any]) {
        self.myMessage = dict["myMessage"] as! Bool
        self.message = dict["message"] as! String
        
        if let userName = dict["userName"] as? String{
            self.userName = userName
        }
    }
    
    init(myMessage: Bool = true, message: String){
        self.myMessage = myMessage
        self.message = message
    }
    
    func toJSON()->[String: Any]{
        var dict = [String: Any]()
        
        dict["myMessage"] = myMessage
        dict["message"] = message
        dict["userName"] = userName
        
        return dict
    }
    
}

