//
//  Models.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import Foundation

class User{
    let username: String
    
    init(username: String){
        self.username = username 
    }
    
}

class Student: User{
    
}

class Teacher: User{
    
}


// Chat Model Message
class ChatMessageModel: NSObject{
    let myMessage: Bool
    let message: String
    var userName: String?
    
    init(myMessage: Bool = true, message: String){
        self.myMessage = myMessage
        self.message = message
    }
    
    
}

