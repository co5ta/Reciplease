//
//  RecipeService.swift
//  Reciplease
//
//  Created by co5ta on 17/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation
import Alamofire

/// Service to request the recipe API
class RecipeService {
    
    private let session: Session
    /// Parameters of the request
    var parameters = [String: Any]()
    /// Shared default object
    static let shared = RecipeService()
    
    /// Allows manual configuration of the session for object not shared
    init(session: Session = .default) {
        self.session = session
    }
}


// MARK: - Methods
extension RecipeService {
    
    /// Request the API to find some recipes
    func getRecipes(ingredients: String, offset: Int, callback: @escaping (Result<SearchResult, AFError>)-> Void) {
         parameters = [
            "app_id": Config.API.app_id,
            "app_key": Config.API.app_key,
            "q": "\(ingredients)",
            "from": offset,
            "to": offset + Config.API.limit
        ]
        
        session.request(Config.API.url, parameters: parameters)
            .validate()
            .responseDecodable(of: SearchResult.self) { (response) in
                callback(response.result)
        }
    }
    
}
