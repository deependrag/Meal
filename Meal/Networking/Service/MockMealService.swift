//
//  MockMealService.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import Foundation

class MockMealService: MealServiceProtocol {
    var shouldFail: Bool = false
    
    private var mockError = NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
    
    func fetchMealList(category: String) async throws -> MealList {
        if shouldFail {
            throw mockError
        }
        return MockData.getMealList()
    }
    
    func fetchMealDetails(for mealId: String) async throws -> Meal {
        if shouldFail {
            throw mockError
        }
        return MockData.getMealDetails()
    }
}
