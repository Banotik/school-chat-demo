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
    var channels = [String]()
    var channelsDict = [String: ChatRoomModel]()
    
    static let shared = ChatRoomHandler()
    // init here
    private override init(){
        Logger.d(clzz: "ChatRoomHandler", description: "init")
 
        let config = PNConfiguration(publishKey: PubNubApi.publishKey, subscribeKey: PubNubApi.subscribeKey)
    
        super.init()
        
        self.client = PubNub.clientWithConfiguration(config)
        self.client.addListener(self)
        initDemoChannel() // for demo
    }
 
    func initDemoChannel(){
        self.addChannel("math")
        self.addChannel("science")
    }
    
    func addChannel(_ name: String){
      
        channels.append(name)
        channelsDict[name] = ChatRoomModel(name: name)
        self.client.subscribeToChannels([name], withPresence: true)
    }
    
    func sendMessage(who: ChatRoomModel, msg: [String: Any], completion: @escaping (_ code: SendMsgCode) -> Void ){
        Logger.d(clzz: "ChatRoomHandler", description: "sendMessage")
        
        let name = who.name
        
        if self.channelsDict[name] != nil{
            
            self.client.publish(msg, toChannel: name, compressed: false, withCompletion: {(status) in
                if !status.isError{
                    // success
                    completion(.success)
                }else{
                    // handle error
                    completion(.error)
                }
            })
        }
        
    }
    
  
    
    // Handle new message from one of channels on which client has been subscribed
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        Logger.d(clzz: "ChatRoomHandler", description: "didRecieveMessage")
        if message.data.channel != message.data.subscription{
            // Message has been received on channel group
            // Message recieved from users in chat
            
            print(1)
        }else{
            print(2)
            // Message recieved from myself
            
            /*
            let who = message.data.channel
            
            if let chatRoom = self.channelsDict[who]{
                chatRoom.recieved(msg: message.data.message)
            }*/
            
        }
        
        DispatchQueue.global().async {
            let who = message.data.channel
            
            if let chatRoom = self.channelsDict[who]{
                if let msg = message.data.message{
                    //message.data.
                    chatRoom.recieved(msg: msg)
                }
            }
        }
    }
}

class ChatRoomModel: NSObject{
    
    weak var delegate: ChatRoomDelegate?
    
    var messageHistory = [ChatMessageModel]()
    
    var history = [String]()
     
    let name: String
    
    init(name: String){
        self.name = name
        
        super.init()
        
    }
    
    func tryToSend(msg: ChatMessageModel, completion: @escaping (_ code: SendMsgCode) -> Void  ){
        Logger.d(clzz: "ChatRoomModel", description: "tryToSend message send \(msg.message)")
        
        // tell chat room handler that a message needs to be send
        ChatRoomHandler.shared.sendMessage(who: self, msg: msg.toJSON(), completion: completion)
        
    }
    
    func add(msg: String){
    }
    func recieved(msg: Any){
        guard let delegate = self.delegate else { 
            return
        }
   
        Logger.d(clzz: "ChatRoomModel", description: "recieved msg: \(msg)")
        if let data = msg as? [String: Any]{
            self.messageHistory.append(ChatMessageModel(dict: data))
            delegate.recieved()
        }
    }
}

enum SendMsgCode{
    case success
    case error
}

protocol ChatRoomDelegate: class {
    func recieved()
    
    func status(code: SendMsgCode)
}
