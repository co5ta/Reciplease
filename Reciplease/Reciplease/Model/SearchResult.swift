//
//  SearchResult.swift
//  Reciplease
//
//  Created by co5ta on 18/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation

/// Recipe API's decoded response
struct SearchResult: Decodable {
    
    /// List of recipes
    let recipes: [Recipe]
}

// MARK: - Coding Keys
extension SearchResult {
    
    /// Give keys to use for decoding
    enum CodingKeys: String, CodingKey {
        case recipes = "hits"
    }
}
