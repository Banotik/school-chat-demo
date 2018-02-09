//
//  ChatRoomViewController.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import UIKit

class ChatRoomViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    
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
        
        let model = ChatMessageModel(message: message)
        
        chatRoomModel.messageHistory.append(model)
        
        inputTextField.text?.clear()
        
        tableView.reloadData()
        
        if !chatRoomModel.messageHistory.isEmpty {
            tableView.scrollToRow(at: IndexPath(item:chatRoomModel.messageHistory.count-1, section: 0), at: .bottom, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set title 
        self.title = chatRoomModel.name.capitalized
        
        // set up table view
        self.tableView.delegate = self
        self.tableView.dataSource = self
        // hide seperator line
        self.tableView.separatorStyle = .none
        // disable selection 
        self.tableView.allowsSelection = false
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
   
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return chatRoomModel.messageHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatMessageBubble", for: indexPath) as! ChatMessageBubble
        
        let messageModel = self.chatRoomModel.messageHistory[indexPath.row]
        
        cell.chatMessageModel = messageModel
     
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
 
}
