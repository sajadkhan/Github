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
    
    // Test for fetching data using github search api with empty text
    
    func testEmptyTextSearch() {
        // text to search
        let text = ""
        
        let expectation = XCTestExpectation(description: "github api expectation")
        
        // make request
        githubRequest?.requestSearchAPI(for: .repo,
                                        searchText: text,
                                        sort: nil,
                                        order: nil,
                                        completion: { items in
                                            XCTAssertNil(items, "Results for repository search api return more than one element for empty text")
                                            expectation.fulfill()
        })
        
        // wait for expectation to fullfil
        wait(for: [expectation], timeout: 20.0)
    }
    
    // Test for fetching data using github search api with result expected text
    func testSomeResultExpectedText() {
        // text to search
        let text = "Github"
        
        let expectation = XCTestExpectation(description: "github api expectation")
        
        // make request
        githubRequest?.requestSearchAPI(for: .repo,
                                        searchText: text,
                                        sort: nil,
                                        order: nil,
                                        completion: { items in
                                            XCTAssert(items != nil && (items?.count)! > 0, "No result for \"github\" using Search Repository API.")
                                            
                                            expectation.fulfill()
        })
        
        // wait for expectation to fullfil
        wait(for: [expectation], timeout: 20.0)
    }
    
    
}
