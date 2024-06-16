//
//  MealCellView.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import SwiftUI

struct MealCellView: View {
    
    //MARK: - Properties
    let meal: Meal
    
    //MARK: - Body
    var body: some View {
        ZStack(alignment: .bottom) {
            mealImageView
            mealTitle
        } //: ZStack
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.vertical, 8)
        .shadow(color: Color.primary.opacity(0.3), radius: 12)
    } //: Body
    
    //MARK: - SubViews
    
    var mealImageView: some View {
        AsyncImage(url: URL(string: meal.strMealThumb ?? "")) { image in
            image.resizable()
                .scaledToFill()
        } placeholder: {
            ProgressView()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 300)
        .background(.secondary.opacity(0.3))
    }
    
    var mealTitle: some View {
        Text(meal.strMeal ?? "")
            .foregroundStyle(.white)
            .font(.largeTitle.bold())
            .fontDesign(.rounded)
            .padding(.horizontal)
            .padding(.vertical, 24)
            .frame(maxWidth: .infinity)
            .background(
                Rectangle()
                    .fill(LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top))
            )
    }
}

//MARK: - Previews
#Preview {
    MealCellView(meal: MockData.getMealDetails())
}
