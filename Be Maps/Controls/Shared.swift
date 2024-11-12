//
//  Shared.swift
//  Be Maps
//
//  Created by Mohammad Jawher on 09/11/2024.
//

import Foundation
import UIKit

final class Shared {
    static let shared = Shared()
    
    var userID = 0
    
    func setIsLogin(bool:Bool){
        let def = UserDefaults.standard
        def.setValue(bool, forKey: "is_Login")
        def.synchronize()
    }
    func getIsLogin()-> Bool?{
        let def = UserDefaults.standard
        return def.object(forKey: "is_Login")as? Bool
    }
    func setUserId(int:Int){
        let def = UserDefaults.standard
        def.setValue(int, forKey: "user_id")
        def.synchronize()
    }
    func getUserId()-> Int?{
        let def = UserDefaults.standard
        return def.object(forKey: "user_id")as? Int
    }
    func setUserName(string:String){
        let def = UserDefaults.standard
        def.setValue(string, forKey: "user_name")
        def.synchronize()
    }
    func getUserName()-> String?{
        let def = UserDefaults.standard
        return def.object(forKey: "user_name")as? String
    }
    
}
