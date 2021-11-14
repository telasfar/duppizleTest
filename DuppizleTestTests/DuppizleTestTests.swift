//
//  DuppizleTestTests.swift
//  DuppizleTestTests
//
//  Created by Tariq Maged on 13/11/2021.
//

import XCTest
import Combine
@testable import DuppizleTest

class DuppizleTestTests: XCTestCase {
    
    private var subject: ProductViewModel!
    private var mockProductService: MockProductService!
    private var cancellables: Set<AnyCancellable> = []

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockProductService = MockProductService()
        subject = ProductViewModel(productService: mockProductService)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellables.forEach { $0.cancel() }
        cancellables.removeAll()
        mockProductService = nil
        subject = nil
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func test_shouldCallService() {
        // when
        subject.fetchProducts()

        // then
        XCTAssertEqual(mockProductService.getCallsCount, 1)
       
    }
    
    func testGettingJSON() {
        let ex = expectation(description: "Expecting a JSON data not nil")
    
        ProductServices.instance.testfetchProductss{ (success, product) in
            XCTAssert(success)
            XCTAssertNotNil(product)
            ex.fulfill()
        }
        
        waitForExpectations(timeout: 10) { (error) in
          if let error = error {
            XCTFail("error: \(error)")
          }
        }
    }


    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
