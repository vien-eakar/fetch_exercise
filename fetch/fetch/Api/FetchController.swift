//
//  FetchController.swift
//  fetch
//
//  Created by Nguyen Vien on 8/13/24.
//

import Foundation

protocol FetchControllerProtocol {
    func fetchMealList(category: String) async throws -> Meals?
    func fetchMealDetail(mealId: String) async throws -> MealModel?
}

struct FetchController: FetchControllerProtocol {
    
    func fetchMealList(category: String) async throws -> Meals? {
        guard let url = URL(string: String(format: fetchMealURL, category)) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let resultData = try? JSONDecoder().decode(Meals.self, from: data) else {
            throw NetworkError.badData
        }
        return resultData
    }
    
    func fetchMealDetail(mealId: String) async throws -> MealModel? {
        guard let url = URL(string: String(format: fetchMealDetailUrl, mealId)) else {
            throw NetworkError.badURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkError.badResponse
        }
        
        guard let resultData = try? JSONDecoder().decode(Meals.self, from: data) else {
            throw NetworkError.badData
        }
        return resultData.listMeals[0]
    }
    
    
}
