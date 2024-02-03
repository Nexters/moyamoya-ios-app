//
//  FunchAppTests.swift
//  FunchAppTests
//
//  Created by Geon Woo lee on 1/27/24.
//

import XCTest

final class ProfileRepositoryTests: XCTestCase {

    /// 나중에 프로토콜로 교체할게요.
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
    
    /// 디바이스 기반 조회
    func test_fetch_profile_from_device_id() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        repository?.fetchProfile { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(true, "일단 api 성공하는지만 체크")
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    /// 프로필 아이디 기반 조회
    func test_fetch_profile_from_id() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        let testableId = "65bdd58cebe5db753688b9fb"
        let query = FetchUserQuery(id: testableId)
        
        repository?.fetchProfileId(userQuery: query) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(true, "일단 api 성공하는지만 체크")
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    /// 유저 생성
    func test_createProfile() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        // mock으로 나중에 뺄게요
        let query = CreateUserQuery(
            name: "박당근",
            birth: "2002-02-15",
            major: "backend",
            clubs: ["nexters"],
            subwayStationName: ["건대입구"],
            mbti: "ISTP"
        )
        repository?.createProfile(createUserQuery: query) { result in
            switch result {
            case .success(let response):
                XCTAssertTrue(true, "일단 api 성공하는지만 체크")
            case .failure(let failure):
                XCTFail(failure.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

}
