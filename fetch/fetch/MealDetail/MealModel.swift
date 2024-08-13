//
//  MealModel.swift
//  fetch
//
//  Created by Nguyen Vien on 8/13/24.
//

import Foundation

struct MealModel: Codable, Identifiable {
    let mealName: String
    let mealId: String
    let mealImage: URL
    var instructions: String = ""
    var ingredients: [String] = []
    var measures: [String] = []
    
    var id: String { mealId }
    
    enum CodingKeys: String, CodingKey {
        case mealName = "strMeal"
        case mealId = "idMeal"
        case mealImage = "strMealThumb"
        case instructions = "strInstructions"
        case ingredients = "strIngredient"
        case measures = "strMeasure"
    }
    
    struct DynamicKey: CodingKey {
        var stringValue: String
        var intValue: Int?
        
        init?(stringValue: String) {
            self.stringValue = stringValue
            self.intValue = nil
        }
        
        init?(intValue: Int) {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.mealName = try container.decode(String.self, forKey: .mealName)
        self.mealId = try container.decode(String.self, forKey: .mealId)
        self.mealImage = try container.decode(URL.self, forKey: .mealImage)
        self.instructions = (try? container.decode(String.self, forKey: .instructions)) ?? ""
        
        var ingredients: [String] = []
        var measures: [String] = []
        
        let dynamicContainer = try decoder.container(keyedBy: DynamicKey.self)
        
        for i in 1...20 {
            let ingredientKey = DynamicKey(stringValue: "strIngredient\(i)")!
            let measureKey = DynamicKey(stringValue: "strMeasure\(i)")!
            
            if let ingredient = try dynamicContainer.decodeIfPresent(String.self, forKey: ingredientKey), !ingredient.isEmpty {
                ingredients.append(ingredient)
            }
            
            if let measure = try dynamicContainer.decodeIfPresent(String.self, forKey: measureKey), !measure.isEmpty {
                measures.append(measure)
            }
        }
        self.ingredients = ingredients
        self.measures = measures
    }
}

struct Meals: Codable {
    let listMeals: [MealModel]
    
    enum CodingKeys: String, CodingKey {
        case listMeals = "meals"
    }
}
