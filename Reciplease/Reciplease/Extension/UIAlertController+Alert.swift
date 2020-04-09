//
//  UIAlertController+Alert.swift
//  Reciplease
//
//  Created by co5ta on 09/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController {
    
    /// Generates a plain alert with a confirmation button
    static func getPlainAlert(title: String, message: String?) -> UIAlertController {
        let alert = UIAlertController(
            title: Strings.errorTitle,
            message: message,
            preferredStyle: .alert)
        let confirm = UIAlertAction(title: "OK", style: .default)
        alert.addAction(confirm)
        return alert
    }
}
