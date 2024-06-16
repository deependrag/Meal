//
//  Helper.swift
//  Meal
//
//  Created by Deependra Dhakal on 6/14/24.
//
import Foundation

func readJSONFromFile<T: Codable>(fileName: String) -> T? {
    if let path = Bundle.main.path(forResource: fileName, ofType: "json") {
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            print("Error decoding JSON: \(error)")
        }
    }
    return nil
}

extension String {
    func extractYoutubeID() -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: self.count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else { return nil }
        return (self as NSString).substring(with: result.range)
    }
}
