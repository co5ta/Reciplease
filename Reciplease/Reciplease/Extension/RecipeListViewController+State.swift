//
//  RecipeListViewController+State.swift
//  Reciplease
//
//  Created by co5ta on 09/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import Foundation

extension RecipeListViewController {
    
    /// States available for the view controller
    enum State {
        /// Getting data
        case loading
        /// Data available
        case ready
        /// No data found
        case empty(mode: Mode)
        /// An error occurred
        case error(message: String?)
        
        /// State title
        var title: String {
            switch self {
            case .empty(let mode):
                return mode == .search ? Strings.emptySearchResultTitle : Strings.noFavoritesTitle
            case .error:
                return Strings.errorTitle
            default:
                return ""
            }
        }
        
        /// Message to explain the cause of the state
        var message: String {
            switch self {
            case .empty(let mode):
                return mode == .search ? Strings.emptySearchResultMessage : Strings.noFavoritesMessage
            case .error(let message):
                return message ?? ""
            default:
                return ""
            }
        }
    }
}
