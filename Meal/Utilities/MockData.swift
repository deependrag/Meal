//
//  MockData.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

class MockData {
    static func getMealList() -> MealList {
        return readJSONFromFile(fileName: "MealList")!
    }
    
    static func getMealDetails() -> Meal {
        let meals: MealList =  readJSONFromFile(fileName: "MealDetails")!
        return (meals.meals?.first)!
    }
}
