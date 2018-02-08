//
//  Chat.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import Foundation

final class ChatRoomManger{
    
    static let shared = ChatRoomManger() 
    
    private init(){}
    
    
    
    var test_chatRooms = ["math", "science", "physics", "art"]
    
    
    
    
}

class ChatRoom{
    let name: String
    
    init(name: String){
        self.name = name
    }
}
