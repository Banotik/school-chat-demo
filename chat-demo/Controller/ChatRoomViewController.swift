//
//  ChatRoomViewController.swift
//  chat-demo
//
//  Created by Huy Vo on 2/7/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import UIKit

class ChatRoomViewController: BaseViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, ChatRoomDelegate{
    
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
        
        let model = ChatMessageModel(uuid: (Auth.auth.user?.uuid)!, message: message)
        
        chatRoomModel.tryToSend(msg: model, completion: { (code) in
            
            switch code{
            case .success:
                print("success")
                self.inputTextField.text?.clear()
            default:
                print("error")
                self.alertMessage(title: "Error", message: "Message could not be send")
            }
            
        })
        
       
    }
    
    func scrollToBottom(){
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
        // set delegate
        self.chatRoomModel.delegate = self
        self.inputTextField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    
    // disable editing UI table
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    func recieved(){
        Logger.d(clzz: "ChatRoomViewController", description: "recieved msg")
        DispatchQueue.main.async {
            // update UI
            self.tableView.reloadData()
            self.scrollToBottom()
        }
    }
    
    func status(code: SendMsgCode) {
        
        switch code{
        case .error:
            print("Error")
        default:
            print("Success")
        }
    }
   
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
      
        inputTextField.resignFirstResponder()
        return true
    }

}
