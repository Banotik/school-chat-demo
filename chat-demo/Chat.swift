//
//  Chat.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import Foundation
import PubNub

class ChatRoomHandler: NSObject, PNObjectEventListener{
    private var client: PubNub!
    
    private var _channels = [String]()
    
    private var _channelsDict = [String: ChatRoomModel]()
    
    static let shared = ChatRoomHandler()
    // init here
    private override init(){
        Logger.d(clzz: "ChatRoomHandler", description: "init")
 
        let config = PNConfiguration(publishKey: PubNubApi.publishKey, subscribeKey: PubNubApi.subscribeKey)
    
        super.init()
        
        self.client = PubNub.clientWithConfiguration(config)
        self.client.addListener(self)
    }
    
    func addChannel(_ name: String){
      
        _channelsDict[name] = ChatRoomModel(name: name)
        
        self.client.subscribeToPresenceChannels([name])
      
    }
    

    func sendMessage(who: ChatRoomModel, msg: String ){
        let name = who.name
        
        if self._channelsDict[name] != nil{
            
            self.client.publish(msg, toChannel: name, compressed: false, withCompletion: {(status) in
                
                if !status.isError{
                    // success
                }else{
                    // handle error
                }
            })
        }
        
    }
    
    // Handle new message from one of channels on which client has been subscribed
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        if message.data.channel != message.data.subscription{
            // Message has been received on channel group
            
        
        }else{
            
        }
        
        print("Received message: \(message.data.message) on channel \(message.data.channel) " +
            "at \(message.data.timetoken)")
        
        let name = message.data.channel
        
        if let chatRoomModel = self._channelsDict[name] {
            chatRoomModel.recieved( msg: message.data.message )
        }
    }
    
    
    
}

final class ChatRoomManger{
    
    static let shared = ChatRoomManger() 
    
    private init(){}
    
    
    
    var test_chatRooms = ["math", "science", "physics", "art"]
    

}

protocol ChatListener{
    
    func message(msg: String)
  
}

class ChatRoomModel: NSObject{
    
    var history = [String]()
    
    let name: String
    
    init(name: String){
        self.name = name
    }
    
    func add(msg: String){
        
        ChatRoomHandler.shared.sendMessage(who: self, msg: msg)
    }

    func recieved(msg: Any){
        
    }
}

protocol ChatRoomDelegate {
    func message(msg: String)
}
