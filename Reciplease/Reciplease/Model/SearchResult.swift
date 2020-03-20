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
    let hits: [Hit]
}
