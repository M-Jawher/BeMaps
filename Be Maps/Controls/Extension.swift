//
//  Extension.swift
//  Be Maps
//
//  Created by Mohammad Jawher on 10/11/2024.
//

import Foundation
import UIKit

extension UITextField {
    func IsEmailValid() -> Bool{
        if !self.text!.isEmpty {
            let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
            return emailTest.evaluate(with: self.text)
        }
        return false
    }
}
