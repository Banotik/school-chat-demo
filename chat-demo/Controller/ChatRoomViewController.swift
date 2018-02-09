//
//  ChatRoomViewController.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import UIKit

class ChatRoomViewController: BaseViewController, UITextFieldDelegate{
    // outlet to input box for user
    @IBOutlet weak var inputTextField: UITextField!
    // chat history 
    @IBOutlet weak var tableView: UITableView!
    var chatRoomModel: ChatRoomModel!
    
    // fetch data from input text field then use pubnug api to
    // send message across network
    @IBAction func onSendMessage(_ sender: Any) {
        Logger.d(clzz: "ChatRoomViewController", description: "onSendMessage")
        
        
        guard let message = inputTextField.text else {
            return
        }
        
        inputTextField.text?.clear()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set title 
        self.title = chatRoomModel.name.capitalized
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 

}
