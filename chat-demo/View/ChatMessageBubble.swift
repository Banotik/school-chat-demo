//
//  ChatMessageBubble.swift
//  chat-demo
//
//  Created by Huy Vo on 2/8/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import UIKit

class ChatMessageBubble: UITableViewCell{
    @IBOutlet weak var receipt: UILabel!
    
    var chatMessageModel: ChatMessageModel!
    
    @IBOutlet weak var message: UITextView!
    
    override func awakeFromNib() {
     
    }
 
    override func draw(_ rect: CGRect) {
       
        initMessageView()
    }
    func initMessageView(){
     
        message.text = chatMessageModel.message
        message.sizeToFit()
        
        message.isEditable = false
        message.layer.cornerRadius = 5.0
        message.backgroundColor = UIColor(rgb: 0x29B6F6)
        message.textColor = UIColor.white
        
        message.frame.origin.x = 10
    
        if chatMessageModel.uuid != Auth.auth.user?.uuid{
            message.frame.origin.x = UIScreen.main.bounds.width-message.frame.width - 40
            message.backgroundColor = UIColor(rgb: 0x00897B)
            
            receipt.text = "\(chatMessageModel.timestamp.formatTime()) from \(chatMessageModel.userName)"
            receipt.sizeToFit()
            receipt.frame.origin.x = UIScreen.main.bounds.width - receipt.frame.width - 40
        }else{
            receipt.isHidden = true
        }
        // message from chat 
        
    }
}
