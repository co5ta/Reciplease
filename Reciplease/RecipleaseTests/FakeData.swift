//
//  FakeData.swift
//  RecipleaseTests
//
//  Created by co5ta on 16/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation
@testable import Reciplease

/// Fake to simulate data from API
class FakeData {
    /// Incorrect json data
    static let jsonBad = "data are bad here".data(using: .utf8)!
    
    /// Correct json data
    static var json: Data {
        let bundle = Bundle(for: self)
        let url = bundle.url(forResource: "Recipes", withExtension: "json")!
        return try! Data(contentsOf: url)
    }
    
    /// Json data decoded
    static var searchResult: SearchResult {
        return try! JSONDecoder().decode(SearchResult.self, from: json)
    }
    
    /// List of recipes
    static var recipes: [Recipe] {
        return searchResult.recipes
    }
}
