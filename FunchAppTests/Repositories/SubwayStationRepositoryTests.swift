//
//  SubwayStationRepositoryTests.swift
//  FunchAppTests
//
//  Created by 이성민 on 2/5/24.
//

import XCTest

final class SubwayStationRepositoryTests: XCTestCase {
    
    // FIXME: 추후 프로토콜로 교체
    var repository: SubwayStationRepository?
    
    override func setUp() {
        super.setUp()
        
        repository = SubwayStationRepository()
    }
    
    override func tearDown() {
        super.tearDown()
        
        repository = nil
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    func test_search_subway_stations() {
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        
        let multipleAvailableValue = "강" // 강남, 강남구청, 강남대
        let query = SearchSubwayStationQuery(searchText: multipleAvailableValue)
//        let singleAvailableValue = "고속터미널" // 고속터미널
//        let query = SearchSubwayStationQuery(searchText: singleAvailableValue)
        
        repository?.searchSubwayStations(searchSubwayStationQuery: query) { result in
            switch result {
            case .success(let response):
                dump(response)
                XCTAssertTrue(true, "잘 받아와지는지 ?")
            case .failure(let failure):
                dump(failure)
                XCTFail(failure.localizedDescription)
            }
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

}
