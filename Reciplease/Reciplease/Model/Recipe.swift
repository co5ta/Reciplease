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
    let label: String
    /// Recipe image url
    let pictureUrl: String
    /// Recipe url
    let url: String
    /// Number of people
    let people: Float
    /// Diet labels
    let dietLabels: [String]
    /// Health labels
    let healthLabels: [String]
    /// Cautions
    let cautions: [String]
    
    ///  Init properties from json data
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let recipe = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        label = try recipe.decode(String.self, forKey: .label)
        pictureUrl = try recipe.decode(String.self, forKey: .pictureUrl)
        url = try recipe.decode(String.self, forKey: .url)
        people = try recipe.decode(Float.self, forKey: .people)
        dietLabels = try recipe.decode([String].self, forKey: .dietLabels)
        healthLabels = try recipe.decode([String].self, forKey: .healthLabels)
        cautions = try recipe.decode([String].self, forKey: .cautions)
    }
}

// MARK: - Coding Keys
extension Recipe {
    
    /// Give keys to use for encoding and decoding
    enum CodingKeys: String, CodingKey {
        case recipe, label, pictureUrl = "image", url, people = "yield", dietLabels, healthLabels, cautions
    }
}
