//
//  AlertHandler.swift
//  GetTipsy
//
//  Created by Martin Malmgren on 2018-10-10.
//  Copyright © 2018 Martin Malmgren. All rights reserved.
//

import Foundation
import UIKit

class AlertHandler {
    func Alert(title : String, Message: String, ButtonTitle : String, sender : AnyObject){
        let alert = UIAlertController(title: title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: ButtonTitle, style: UIAlertAction.Style.default, handler: nil))
        sender.present(alert, animated: true, completion: nil)
    }
    
    
}
