//
//  Recipe.swift
//  Reciplease
//
//  Created by co5ta on 18/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation

/// Recipe entity
struct Recipe: Decodable {
    
    /// Recipe namess
    let title: String
    /// Recipe image url
    let pictureUrl: String
    /// Recipe url
    let url: String
    /// Number of people
    let people: Float
    /// Health labels
    let healthLabels: [String]
    /// Cautions
    let cautionLabels: [String]
    /// Ingredients
    let ingredients: [String]
    
    ///  Init properties from json data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let recipe = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        title = try recipe.decode(String.self, forKey: .title)
        pictureUrl = try recipe.decode(String.self, forKey: .pictureUrl)
        url = try recipe.decode(String.self, forKey: .url)
        people = try recipe.decode(Float.self, forKey: .people)
        healthLabels = try recipe.decode([String].self, forKey: .healthLabels)
        cautionLabels = try recipe.decode([String].self, forKey: .cautionLabels)
        ingredients = try recipe.decode([String].self, forKey: .ingredients)
    }
}

// MARK: - Coding Keys
extension Recipe {
    
    /// Give keys to use for encoding and decoding
    enum CodingKeys: String, CodingKey {
        case recipe
        case title = "label"
        case pictureUrl = "image"
        case url
        case people = "yield"
        case healthLabels
        case cautionLabels = "cautions"
        case ingredients = "ingredientLines"
    }
}
