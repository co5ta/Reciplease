//
//  URLProtocolMock.swift
//  RecipleaseTests
//
//  Created by co5ta on 17/04/2020.
//  Copyright © 2020 Co5ta. All rights reserved.
//

import UIKit
@testable import Reciplease
@testable import Alamofire

/// Mock to intercept request and simulate a response
class URLProtocolMock: URLProtocol {
    
    /// Dictionary that maps URLs to test data
    static var testURLs: [URL: Result<Data, Error>] = [
        makeURL(with: "jsonGood"): .success(FakeData.json),
        makeURL(with: "jsonBad"): .success(FakeData.jsonBad)
    ]

    /// Generates an URL similar to
    static func makeURL(with ingredients: String) -> URL{
        var url = Config.API.url
        url += "?app_id=\(Config.API.app_id)"
        url += "&app_key=\(Config.API.app_key)"
        url += "&from=0"
        url += "&q=\(ingredients)"
        url += "&to=10"
        return URL(string: url)!
    }
    
    /// Determines whether the protocol subclass can handle the specified request
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    /// Returns a canonical version of the specified request
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    /// Starts protocol-specific loading of the request.
    override func startLoading() {
        print(request.url!)
        guard let response = URLProtocolMock.testURLs[request.url!]
            else {
                self.client?.urlProtocol(self, didFailWithError: AFError.invalidURL(url: request.url!))
                return
            }
        
        switch response {
        case .failure(let error):
            self.client?.urlProtocol(self, didFailWithError: error) // Simulate the error
        case .success(let data):
            self.client?.urlProtocol(self, didLoad: data) // Simulate the data reception
            self.client?.urlProtocolDidFinishLoading(self) // Stop the loading
        }
    }
    
    /// Stops protocol-specific loading of the request
    override func stopLoading() {}
}
