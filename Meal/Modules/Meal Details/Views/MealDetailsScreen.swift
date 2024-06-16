//
//  MealDetailsScreen.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import SwiftUI

struct MealDetailsScreen: View {
    
    //MARK: - Properties
    let viewModel: MealDetailsViewModel
    
    //MARK: - Body
    var body: some View {
        VStack(alignment: .leading) {
            switch viewModel.viewState {
            case .progress:
                ProgressView()
                
            case .error(let error):
                errorView(error)
                
            case .data:
                ScrollView {
                    mealThumbnailView
                    
                    VStack(alignment: .leading, spacing: 24) {
                        mealTitleView
                        mealIngredientsView
                        mealInstructionsView
                        youtubeView
                        sourceView
                    }
                    .padding()
                }//: Scroll View
            } //: Switch Case
        } //: VStack
        .ignoresSafeArea(edges: .top)
        .scrollIndicators(.hidden)
        .onAppear {
            viewModel.fetchMealDetails()
        }
    } //: Body
    
    // MARK: - SubViews
    
    var mealThumbnailView: some View {
        Group {
            if let thumbnailURL = viewModel.thumbnailURL {
                AsyncImage(url: thumbnailURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                        .frame(height: 400)
                }
                .frame(maxWidth: .infinity)
                .background(.gray.opacity(0.1))
                .clipped()
            }
        }
    }
    
    var mealTitleView: some View {
        Group {
            if let mealTitle = viewModel.mealTitle {
                Text(mealTitle)
                    .font(.title.bold())
                    .fontDesign(.rounded)
            }
        }
    }
    
    var mealIngredientsView: some View {
        Group {
            if let ingredients = viewModel.mealIngredientWithMeasurement, !ingredients.isEmpty {
                MealIngredientsView(ingredients: ingredients)
            }
        }
    }
    
    var mealInstructionsView: some View {
        Group {
            if let mealInstructions = viewModel.mealInstructions {
                GroupBox("Instructions") {
                    Text(mealInstructions)
                        .font(.subheadline)
                }
            }
        }
    }
    
    var youtubeView: some View {
        Group {
            if let youtubeLink = viewModel.mealYoutubeVideoID, !youtubeLink.isEmpty {
                YoutubeView(videoID: youtubeLink)
                    .frame(height: 230)
                    .cornerRadius(16)
            }
        }
    }
    
    var sourceView: some View {
        Group {
            if let sourceLink = viewModel.mealSourceLink {
                GroupBox() {
                    HStack {
                        Text("Content Source")
                        
                        Spacer()
                        
                        Link("Visit Site", destination: sourceLink)
                        
                        Image(systemName: "arrow.up.right.square")
                            .foregroundColor(.blue)
                        
                    }
                    .font(.footnote)
                }
            }
        }
    }
    
    func errorView(_ error: String) -> some View {
        ErrorView(error: error) {
            viewModel.fetchMealDetails()
        }
    }
}

// MARK: - Previews
#Preview {
    MealDetailsScreen(viewModel: MealDetailsViewModel(mealService: MockMealService(), mealID: "53049"))
}
