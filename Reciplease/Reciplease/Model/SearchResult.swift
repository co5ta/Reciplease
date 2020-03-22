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
    
    /// First result index
    let from: Int
    /// Last result index
    let to: Int
    /// Total number of results found
    let count: Int
    /// List of recipes
    let recipes: [Recipe]
}

// MARK: - Coding Keys
extension SearchResult {
    
    /// Give keys to use for decoding
    enum CodingKeys: String, CodingKey {
        case from, to, count, recipes = "hits"
    }
}
