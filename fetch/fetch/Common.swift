//
//  Common.swift
//  fetch
//
//  Created by Nguyen Vien on 8/13/24.
//

import Foundation

// API fetch status
enum Status {
    case notStarted
    case fetching
    case success
    case empty
    case failed(error: Error)
}

// API error
enum NetworkError: Error {
    case badURL, badResponse, badData
}

// URL Define
let fetchMealURL = "https://themealdb.com/api/json/v1/1/filter.php?c=%@"
let fetchMealDetailUrl = "https://themealdb.com/api/json/v1/1/lookup.php?i=%@"


// Array Extention
extension Array {
    public subscript(safeIndex index: Int) -> Element? {
        guard index >= 0, index < endIndex else {
            return nil
        }
        
        return self[index]
    }
}
