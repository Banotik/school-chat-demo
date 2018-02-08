//
//  Test.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import Foundation
import PubNub


class ChatTester: NSObject, PNObjectEventListener{
    
    var client: PubNub!
    
    static let shared = ChatTester()
    
    private override init(){
        let config = PNConfiguration(publishKey: PubNubApiClient.publishKey, subscribeKey: PubNubApiClient.subscribeKey)
        
        
        self.client = PubNub.clientWithConfiguration(config)
        
        super.init()
        
        
        self.client.addListener(self)
        
        self.client.subscribeToChannels(["my_channel"], withPresence: true)
    
    
    }
    
    func add(msg: String){
        
        self.client.publish(msg, toChannel: "my_channel", compressed: false, withCompletion: {(status) in
            
            if !status.isError{
                print(msg)
            }else{
                // handle error
            }
        })
        
    }
    
    // Handle new message from one of channels on which client has been subscribed
    func client(_ client: PubNub, didReceiveMessage message: PNMessageResult) {
        if message.data.channel != message.data.subscription{
            // Message has been received on channel group
        }else{
            
        }
        
        print("Received message: \(message.data.message) on channel \(message.data.channel) " + "at \(message.data.timetoken)")
    }
    
    // New presence event handling.
    func client(_ client: PubNub, didReceivePresenceEvent event: PNPresenceEventResult) {
        
        // Handle presence event event.data.presenceEvent (one of: join, leave, timeout, state-change).
        if event.data.channel != event.data.subscription {
            
            // Presence event has been received on channel group stored in event.data.subscription.
        }
        else {
            
            // Presence event has been received on channel stored in event.data.channel.
        }
        
        if event.data.presenceEvent != "state-change" {
            
            print("\(event.data.presence.uuid) \"\(event.data.presenceEvent)'ed\"\n" +
                "at: \(event.data.presence.timetoken) on \(event.data.channel) " +
                "(Occupancy: \(event.data.presence.occupancy))");
        }
        else {
            
            print("\(event.data.presence.uuid) changed state at: " +
                "\(event.data.presence.timetoken) on \(event.data.channel) to:\n" +
                "\(event.data.presence.state)");
        }
    }
}
