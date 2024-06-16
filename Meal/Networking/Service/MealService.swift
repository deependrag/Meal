//
//  MealService.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

protocol MealServiceProtocol {
    func fetchMealList(category: String) async throws -> MealList
    func fetchMealDetails(for mealId: String) async throws -> Meal
}

class MealService: MealServiceProtocol {
    func fetchMealList(category: String) async throws -> MealList {
        return try await NetworkClient.executeRequest(MealRequest.MealList(queryParams: ["c": category]))
    }
    
    func fetchMealDetails(for mealId: String) async throws -> Meal {
        let mealDetails: MealList =  try await NetworkClient.executeRequest(MealRequest.MealDetails(queryParams: ["i" : mealId]))
        guard let meal = mealDetails.meals?.first else { throw NetworkError.invalidData}
        return meal
    }
}
