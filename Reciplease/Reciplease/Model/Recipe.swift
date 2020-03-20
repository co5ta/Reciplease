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
    
    /// Recipe title
    let label: String
    
    /// Recipe image
    let image: String
    
    /// Recipe url
    let url: String
    
    /// Number of people
    let people: Float
    
    /**  Init properties from json data */
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let recipe = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .recipe)
        label = try recipe.decode(String.self, forKey: .label)
        image = try recipe.decode(String.self, forKey: .image)
        url = try recipe.decode(String.self, forKey: .url)
        people = try recipe.decode(Float.self, forKey: .people)
    }
}

// MARK: - Coding Keys

extension Recipe {
    /// Give keys to use for encoding and decoding
    enum CodingKeys: String, CodingKey {
        case recipe, label, image, url, people = "yield"
    }
}
