//
//  MealListViewModelTests.swift
//  MealTests
//
//  Created by Deependra Dhakal on 6/15/24.
//

import XCTest
@testable import Meal

final class MealListViewModelTests: XCTestCase {
    
    var viewModel: MealListViewModel!
    var mockMealService: MockMealService!
    
    override func setUp() {
        super.setUp()
        mockMealService = MockMealService()
        viewModel = MealListViewModel(mealService: mockMealService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockMealService = nil
        super.tearDown()
    }

    func testFetchMealListSuccess() async {
        let expectation = XCTestExpectation(description: "Fetch Meal List Success")
        
        viewModel.fetchMealList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.viewState, .data)
            XCTAssertFalse(self.viewModel.mealList.isEmpty)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
        
    }

    func testFetchMealListFailure() async {
        let expectation = XCTestExpectation(description: "Fetch Meal List Failure")
        mockMealService.shouldFail = true
        
        viewModel.fetchMealList()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.viewState, .error("Mock error"))
            XCTAssertTrue(self.viewModel.mealList.isEmpty)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
}
