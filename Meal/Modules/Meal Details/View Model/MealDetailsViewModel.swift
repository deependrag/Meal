//
//  MealDetailsViewModel.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import Observation
import Foundation

@Observable
class MealDetailsViewModel {
    
    // MARK: - Properties
    var viewState: ViewState = .progress
    
    private var meal: Meal?
    private var mealID: String
    private let mealService: MealServiceProtocol
    
    // MARK: - Initializer
    init(mealService: MealServiceProtocol, mealID: String) {
        self.mealService = mealService
        self.mealID = mealID
    }
    
    // MARK: - Computed Properties for UI Data
    var isMealLoaded: Bool {
        return meal != nil
    }
    
    var thumbnailURL: URL? {
        URL(string: meal?.strMealThumb ?? "")
    }
    
    var mealTitle: String? {
        return meal?.strMeal
    }
    
    var mealInstructions: String? {
        return meal?.strInstructions
    }
    
    var mealYoutubeVideoID: String? {
        return meal?.strYoutube?.extractYoutubeID()
    }
    
    var mealSourceLink: URL? {
        if let mealSource = meal?.strSource {
            return URL(string: mealSource)
        }
        return nil
    }
    
    var mealIngredientWithMeasurement: [String : String]? {
        return meal?.ingredientsWithMeasurement
    }
    
    //MARK: - Methods
    
    /// Fetches the meal details from the service.
    func fetchMealDetails() {
        viewState = .progress
        
        Task {
            do {
                meal = try await mealService.fetchMealDetails(for: mealID)
                viewState = .data
            }catch {
                viewState = .error(error.localizedDescription)
            }
        }
    }
}
