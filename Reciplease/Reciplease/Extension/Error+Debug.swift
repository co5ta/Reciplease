//
//  Error+Debug.swift
//  Reciplease
//
//  Created by co5ta on 20/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation

extension Error {
    
    /// A more explicit explanation of the error
    var debugDescription: String {
        "\(String(describing: type(of: self))).\(String(describing: self)) (code \((self as NSError).code))"
    }
}
