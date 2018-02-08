//
//  ChatRoomViewController.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import UIKit

class ChatRoomViewController: UIViewController {
    
    var chatRoomModel: ChatRoomModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // set title 
        self.title = chatRoomModel.name
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
