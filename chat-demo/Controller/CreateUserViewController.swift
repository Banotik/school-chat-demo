//
//  CreateUserViewController.swift
//  chat-demo
//
//  Created by Huy Vo on 2/9/18.
//  Copyright © 2018 Huy Vo. All rights reserved.
//

import UIKit

// To create a user (Teacher or Student)
class CreateUserViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onStudent(_ sender: Any) {
    
        Auth.auth.signUp(guest: Student(username: "student"))
        

        self.jumpStoryBoard(name: "Main")
    }
}
