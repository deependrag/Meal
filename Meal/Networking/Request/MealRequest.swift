//
//  MealRequest.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//

import Foundation

class MealRequest {
    struct MealList: Request {
        var path: String = NetworkConstants.filterPath
        var queryParams: [String : Any]?
        init(queryParams: [String : Any]?) {
            self.queryParams = queryParams
        }
    }
    
    struct MealDetails: Request {
        var path: String = NetworkConstants.lookupPath
        var queryParams: [String : Any]?
        init(queryParams: [String : Any]?) {
            self.queryParams = queryParams
        }
    }
}
