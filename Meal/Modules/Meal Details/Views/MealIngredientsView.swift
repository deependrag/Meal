//
//  MealIngredientsView.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import SwiftUI

struct MealIngredientsView: View {
    //MARK: - Properties
    var ingredients: [String:String]
    
    //MARK: - Body
    var body: some View {
        GroupBox() {
            DisclosureGroup("Ingredients") {
                ForEach(ingredients.sorted(by: >), id: \.key) { key, value in
                    Divider()
                        .padding(.vertical, 2)
                    HStack {
                        Group {
                            Image(systemName: "info.circle")
                            
                            // Ingredients Title
                            Text(key)
                        }
                        .foregroundColor(.accentColor)
                        .font(.headline.bold())
                        
                        Spacer(minLength: 25)
                        
                        //Ingredients Measurements
                        Text(value)
                            .multilineTextAlignment(.trailing)
                    }//: HStack
                }//: ForEach
            }//: Disclosure Group
        }//: Box
    }
}

#Preview {
    MealIngredientsView(ingredients: MockData.getMealDetails().ingredientsWithMeasurement)
}
