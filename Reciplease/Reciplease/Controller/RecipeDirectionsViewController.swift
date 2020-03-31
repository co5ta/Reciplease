//
//  RecipeDirectionsViewController.swift
//  Reciplease
//
//  Created by co5ta on 31/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit
import WebKit

/// Controller of the recipe directions screen
class RecipeDirectionsViewController: UIViewController, WKUIDelegate {

    /// URL of the recipe
    var recipeURL: URL?
    /// Web view to display the content
    var webView = WKWebView()
}

// MARK: - Lifecycle
extension RecipeDirectionsViewController {
    
    /// Called after the controller's view is loaded into memory
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
}

// MARK: - Setup
extension RecipeDirectionsViewController {
    
    /// Sets up the views
    private func setUpViews() {
        setUpWebView()
        openRecipeURL()
    }
    
    /// Sets up the web view
    private func setUpWebView() {
        webView.uiDelegate = self
        view = webView
    }
}

// MARK: - Data
extension RecipeDirectionsViewController {
    
    /// Opens the URL of the recipe directions
    private func openRecipeURL() {
        guard let recipeURL = recipeURL else { return }
        print(recipeURL.absoluteURL)
        let request = URLRequest(url: recipeURL)
        webView.load(request)
    }
}
