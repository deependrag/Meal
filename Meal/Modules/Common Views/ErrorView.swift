//
//  ErrorView.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/15/24.
//

import SwiftUI

struct ErrorView: View {
    // MARK: - Properties
    let error: String
    let action: () -> Void
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(error)
                .font(.headline.bold())
                .fontDesign(.rounded)
                .multilineTextAlignment(.center)
            
            Button("Retry") { action() }
                .buttonStyle(.borderedProminent)
        }//: VStack
        .padding()
    }
}

// MARK: - Previews
#Preview {
    ErrorView(error: "Error occured while fetching the data. Please try again refreshing the page.", action: {
        print("Retry Tapped")
    })
}
