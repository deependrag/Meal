//
//  MealListScreen.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import SwiftUI

struct MealListScreen: View {
    // MARK: - Properties
    private var viewModel = MealListViewModel(mealService: MealService())
    
    @State private var path = NavigationPath()
    
    // MARK: - Body
    var body: some View {
        NavigationStack(path: $path) {
            VStack {
                switch viewModel.viewState {
                case .progress:
                    ProgressView()
                    
                case .error(let error):
                    errorView(error)
                    
                case .data:
                    mealListView
                }
            } //: VStack
            .navigationDestination(for: Meal.self, destination: { meal in
                MealDetailsScreen(
                    viewModel: MealDetailsViewModel(
                        mealService: MealService(),
                        mealID: meal.idMeal ?? ""
                    )
                )
            })
            .navigationTitle(viewModel.mealCategory)
            .onAppear {
                viewModel.fetchMealList(refresh: false)
            }
        } //: Navigation Stack
    } //: Body
    
    // MARK: - SubViews
    
    /// A view that displays the list of meals.
    var mealListView: some View {
        List(viewModel.mealList, id: \.idMeal) { meal in
            Button {
                path.append(meal)
            } label: {
                MealCellView(meal: meal)
            }
            .listRowSeparator(.hidden)
            
        } //: List View
        .listStyle(.plain)
        .refreshable {
            viewModel.fetchMealList()
        } //: Refreshable
    }
    
    /// A view that displays the error.
    func errorView(_ error: String) -> some View {
        ErrorView(error: error) {
            viewModel.fetchMealList(refresh: true)
        }
    }
}

// MARK: - Preview
#Preview {
    MealListScreen()
}
