//
//  UsersM.swift
//  Be Maps
//
//  Created by Mohammad Jawher on 10/11/2024.
//

import Foundation


class UsersM: NSObject {
    
    var userId = 0
    var userEmail = ""
    var userPassword = ""

    
    init(userId: Int!, userEmail:String!, userPassword:String!) {
        self.userId = userId
        self.userEmail = userEmail
        self.userPassword = userPassword
    }
    
}
