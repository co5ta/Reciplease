//
//  NetworkTests.swift
//  RecipleaseTests
//
//  Created by co5ta on 17/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import XCTest
@testable import Reciplease
@testable import Alamofire

/// A class to tests behaviors after network requests
class NetworkTests: XCTestCase {
    
    /// Objetcs which do the request
    var recipeService: RecipeService!
    /// Object which creates and manages Alamofire’s Request types during their lifetimes
    var session: Session!
    
    /// Provides an opportunity to reset state before each test method in a test case is called
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [URLProtocolMock.self]
        session = Session(configuration: configuration)
        recipeService = RecipeService(session: session)
    }
    
    /// Tests the reception of good data
    func testRecipesFetching() {
        let expectedResult = FakeData.recipes
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        recipeService.getRecipes(ingredients: "jsonGood", offset: 0) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.debugDescription, "")
            case .success(let searchResult):
                XCTAssertEqual(expectedResult, searchResult.recipes)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
    
    /// Tests the reception of invalid data
    func testRecipesFetchingBadJson() {
        let expectation = XCTestExpectation(description: "Wait for queue change")
        
        recipeService.getRecipes(ingredients: "jsonBad", offset: 0) { (result) in
            switch result {
            case .failure(let error):
                XCTAssertNotNil(error.debugDescription.contains("The given data was not valid JSON"))
            case .success:
                XCTFail()
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
}
