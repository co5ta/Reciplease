//
//  API.swift
//  Reciplease
//
//  Created by co5ta on 20/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation

/// Gather the parameters of the application
enum Config {
    
    /// Configuration of the recipe API
    enum API {
        /// URL of the API
        static let url = "https://api.edamam.com/search"
        /// ID of the user of the API
        static let app_id = "2e2b7a80"
        /// Key of the user of the API
        static let app_key = "e0af9c94daa4af7d0dc971bb15389075"
    }
}
