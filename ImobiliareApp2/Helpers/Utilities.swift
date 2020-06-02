//
//  Utilities.swift
//  Imobiliare
//
//  Created by user169246 on 5/20/20.
//  Copyright © 2020 Costache_Adriana. All rights reserved.
//

import Foundation
import UIKit

class Utilities{
    
    static func styleTextField(_ textField:UITextField){
        //create the bottom line
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0, y: textField.frame.height - 2, width: textField.frame.width, height: 2)
        
        bottomLine.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1).cgColor
        
        //remove border on text field
        textField.borderStyle = .none
        //textField.backgroundColor = UIColor.init(red: 48/255, green: 173/255, blue: 99/255, alpha: 1)
        
        
        
        //add the line to the text field
        textField.layer.addSublayer(bottomLine)
        
    }
    static func styleLabel(_ label : UILabel){
        
        label.highlightedTextColor = UIColor(red: 48/255, green:173/255, blue: 99/255, alpha:1)
        
    }
    static func styleFilledButton(_ button:UIButton){
        //FILED rounded corner style
        button.backgroundColor = UIColor.init(red: 48/255, green:173/255, blue: 99/255, alpha:1)
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.white
    }
    
    static func styleHollowButton(_ button: UIButton){
        //Hollow rounded corner style
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 25.0
        button.tintColor = UIColor.black
    }
    
    static func isPasswordValid (_ password : String)->Bool{
         let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        return passwordTest.evaluate(with: password)
    }
}
