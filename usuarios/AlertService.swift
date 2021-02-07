//
//  AlertService.swift
//  usuarios
//
//  Created by user177248 on 2/7/21.
//

import UIKit

class AlertService{

    func alert(message: String) -> UIAlertController {

        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)

        let action = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)

        alert.addAction(action)

        return alert
    }

}
