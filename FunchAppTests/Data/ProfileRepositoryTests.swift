//
//  FunchAppTests.swift
//  FunchAppTests
//
//  Created by Geon Woo lee on 1/27/24.
//

import XCTest

final class ProfileRepositoryTests: XCTestCase {

    var repository: ProfileRepository?
    
    override func setUp() {
        super.setUp()
        
        repository = ProfileRepository()
    }

    override func tearDown() {
        super.tearDown()
        
        repository = nil
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_fetchProfile() {
        repository?.fetchProfile { result in
            switch result {
            case .success(let response):
                break
            case .failure(let failure):
                XCTFail("api failure")
            }
        }
    }

}
