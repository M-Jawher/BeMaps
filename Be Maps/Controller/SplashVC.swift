//
//  SplashVC.swift
//  Be Maps
//
//  Created by Mohammad Jawher on 11/11/2024.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if Shared.shared.getIsLogin() == true{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let root = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(root, animated: true, completion: nil)
        }else{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let root = storyboard.instantiateViewController(withIdentifier: "LoginVC")
            self.present(root, animated: true, completion: nil)
        }
    }
    

}
