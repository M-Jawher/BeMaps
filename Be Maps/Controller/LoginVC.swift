//
//  LoginVC.swift
//  Be Maps
//
//  Created by Mohammad Jawher on 09/11/2024.
//

import UIKit
import Firebase
import Toast_Swift

class LoginVC: UIViewController {
    
    var ref = Database.database().reference()
    var dataList : [UsersM] = []
    let style = ToastStyle()
    var userId = 0

    @IBOutlet weak var userNameTxt: UITextField!
    @IBOutlet weak var passwordTxt: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Shared.shared.getIsLogin() == true{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let root = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(root, animated: true, completion: nil)
        }
        getUsersData()
    }
    @IBAction func goToMapBtn(_ sender: Any) {
        if userNameTxt.text?.isEmpty == true{
            self.view.makeToast("Please enter your email", duration: 4.0, position: .bottom, style: style)
        }else
        if userNameTxt.IsEmailValid() != true{
            self.view.makeToast("invalid email", duration: 4.0, position: .bottom, style: style)
        }else
        if passwordTxt.text?.isEmpty == true{
            self.view.makeToast("Please enter your password", duration: 4.0, position: .bottom, style: style)
        }else
        {
            for check in dataList{
                if userNameTxt.text == check.userEmail{
                    if passwordTxt.text == check.userPassword{
                        userId = check.userId
                        presentRoot()
                    }
                    break
                }else{
                    setUserData()
                    presentRoot()
                }
            }
            if dataList.count == 0{
                    setUserData()
                    presentRoot()
            }
        }
    }
    func setUserData(){
        userId = dataList.count
        let usersData = self.ref.child("usersData").child(String(userId))
            let input = ["status":"0",
                         "email":"\(self.userNameTxt.text ?? "")",
                         "password":"\(self.passwordTxt.text ?? "")"]
            usersData.setValue(input)
    }
    func getUsersData(){
        ref.child("usersData").observe(.childAdded, with: { snapshot in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {
               return
           }
            let obj = UsersM(userId: Int(snapshot.key), userEmail: dictionary["email"] as? String, userPassword: dictionary["password"] as? String)
           self.dataList.append(obj)
        })
    }
    func presentRoot(){
        self.userNameTxt.text = ""
        self.passwordTxt.text = ""
        let rootVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        self.present(rootVC, animated: true)
        Shared.shared.setIsLogin(bool: true)
        Shared.shared.setUserId(int: userId)
        Shared.shared.setUserName(string: self.userNameTxt.text ?? "")
    }
    
}


