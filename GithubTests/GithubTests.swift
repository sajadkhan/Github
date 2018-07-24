//
//  GithubTests.swift
//  GithubTests
//
//  Created by Sajad on 7/24/18.
//  Copyright © 2018 Sajad. All rights reserved.
//

import XCTest
@testable import Github

class GithubTests: XCTestCase {
    
    // MARK: - Properties
    
    var githubRequest: GithubRequest?
    
    // MARK: - Setup and Teardown
    
    override func setUp() {
        super.setUp()
        githubRequest = GithubRequest()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK: - Tests
    
    //Test url creation with params
    
    func testURLCreationWithValidParams() {
        let params: [String: String?] = ["param1": "Value1",
                                         "param2": "Value2"]
        let url = URL(string: "https://api.github.com")!
        
        
        let urlByAppendingParams = url.withQueries(params)
        
        XCTAssertNotNil(urlByAppendingParams, "Url was not created with queries")
        XCTAssertNotNil(urlByAppendingParams?.query, "Url query is not created with params")
        XCTAssertEqual(urlByAppendingParams!.query!, "param1=Value1&param2=Value2", "Url query created with unmatched params")
    }
    
    func testURLCreationWithNilValueParmas() {
        let params: [String: String?] = ["param1": "Value1",
                                         "param2": nil]
        let url = URL(string: "https://api.github.com")!
        
        let urlByAppendingParams = url.withQueries(params)
        
        XCTAssertNotNil(urlByAppendingParams, "Url was not created with queries")
        XCTAssertNotNil(urlByAppendingParams?.query, "Url query is not created with params")
        XCTAssertEqual(urlByAppendingParams!.query!, "param1=Value1&param2", "Url query created with unmatched params")
    }
    
    // Test URL creation against a specific search api
    
    func testURLCreationAgainstAPI() {
        // Create actual url
        let params: [String: String?] = ["param1": "Value1",
                                         "param2": "Value2"]
        let actualURL = URL(string: "https://api.github.com/search/repositories")!.withQueries(params)!
        
        // Use GithubRequest API to create url
        let url = githubRequest?.urlForSearchAPI(.repo, withParams: params)!
        
        // Check if right url is created
        XCTAssertEqual(actualURL, url, "Wrong url against search api")
        
        
    }
    
    
    
}
