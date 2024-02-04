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
        
        let testableReuqestId: String = "65bf251debe5db753688ba02" // 성민
        // 성민- 65bf251debe5db753688ba02
        // 건우- 65bf253febe5db753688ba03
        let testableTargetUserCode: String = "G36K" // 건우
        // 성민- 2M5N
        // 건우- G36K
        
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
