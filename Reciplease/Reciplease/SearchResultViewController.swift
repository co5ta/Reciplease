//
//  SearchResultViewController.swift
//  Reciplease
//
//  Created by co5ta on 17/03/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit
import Alamofire

class SearchResultViewController: UIViewController {
    
    var ingredients: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        getRecipes()
    }
    
    @objc func getRecipes(){
        let parameters = [
            "app_id": "2e2b7a80",
            "app_key": "e0af9c94daa4af7d0dc971bb15389075",
            "q": "chicken"
        ]
        AF.request("https://api.edamam.com/search", parameters: parameters).response { (data) in
            debugPrint(data)
        }
    }
}
