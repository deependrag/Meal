//
//  MealDetailsViewModelTests.swift
//  MealTests
//
//  Created by Deependra Dhakal on 6/15/24.
//

import XCTest
@testable import Meal

final class MealDetailsViewModelTests: XCTestCase {

    var viewModel: MealDetailsViewModel!
    var mockMealService: MockMealService!
    
    override func setUp() {
        super.setUp()
        mockMealService = MockMealService()
        viewModel = MealDetailsViewModel(mealService: mockMealService, mealID: "")
    }
    
    override func tearDown() {
        viewModel = nil
        mockMealService = nil
        super.tearDown()
    }
    
    func testFetchMealDetailsSuccess() async {
        let expectation = XCTestExpectation(description: "Fetch meal details success")
        
        viewModel.fetchMealDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.viewState, .data)
            XCTAssertTrue(self.viewModel.isMealLoaded)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testFetchMealDetailsFailure() async {
        let expectation = XCTestExpectation(description: "Fetch meal details failure")
        mockMealService.shouldFail = true
        
        viewModel.fetchMealDetails()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertEqual(self.viewModel.viewState, .error("Mock error"))
            XCTAssertFalse(self.viewModel.isMealLoaded)
            expectation.fulfill()
        }
        
        await fulfillment(of: [expectation], timeout: 2.0)
    }
    
    func testMealIngredientsMappedCorrectly() {
        let ingredients = MockData.getMealDetails().ingredientsWithMeasurement
        
        let expectedIngredients = [
            "Milk" : "200ml",
            "Oil" : "60ml",
            "Eggs" : "2",
            "Flour" : "1600g",
            "Baking Powder" : "3 tsp",
            "Salt" : "1/2 tsp",
            "Unsalted Butter" : "25g",
            "Sugar" : "45g",
            "Peanut Butter" : "3 tbs"
        ]
        
        XCTAssertEqual(ingredients.count, expectedIngredients.count)
        
        for (ingredient, measurement) in expectedIngredients {
            XCTAssertEqual(ingredients[ingredient], measurement)
        }
    }

}
