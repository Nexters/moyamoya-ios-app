//
//  MatchingRepository.swift
//  FunchAppTests
//
//  Created by Geon Woo lee on 2/3/24.
//

import XCTest
final class MatchingRepositoryTests: XCTestCase {
    
    /// 나중에 프로토콜로 교체할게요.
    var repository: MatchingRepository?
    
    override func setUp() {
        super.setUp()
        
        repository = MatchingRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        
        repository = nil
    }
    
    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    func test_프로필_매칭() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        let testableReuqestId: String = "65bdd58cebe5db753688b9fb"
        let testableTargetUserCode: String = "GP38"
        
        let query = MatchingUserQuery(
            requestId: testableReuqestId,
            targetUserCode: testableTargetUserCode
        )
        
        repository?.matchingUser(searchUserQuery: query) { result in
            switch result {
            case .success(let success):
                XCTAssertTrue(true, "일단 api 성공하는지만 체크")
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
