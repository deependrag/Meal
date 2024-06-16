//
//  MealListViewModel.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import Observation

enum ViewState: Equatable {
    case progress
    case error(String)
    case data
}

@Observable
class MealListViewModel {
    
    // MARK: - Properties
    var viewState: ViewState = .progress
    var mealList: [Meal] = []
    var mealCategory = "Dessert"
    
    private let mealService: MealServiceProtocol
    
    // MARK: - Initializer
    init(mealService: MealServiceProtocol) {
        self.mealService = mealService
    }
    
    // MARK: - Methods
        
    /// Fetches the meal list from the service.
    /// - Parameter refresh: A boolean to determine if the meal list should be refreshed. Default is `true`.
    func fetchMealList(refresh: Bool = true) {
        guard mealList.isEmpty || refresh else {return}
        
        viewState = .progress
        
        Task {
            do {
                mealList = try await mealService.fetchMealList(category: mealCategory).meals?
                    .sorted(by:{ ($0.strMeal ?? "") < ($1.strMeal ?? "") }) ?? []
                viewState = .data
            } catch {
                viewState = .error(error.localizedDescription)
            }
        }
    }
}
