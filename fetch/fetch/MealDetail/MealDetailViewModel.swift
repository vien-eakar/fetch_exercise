//
//  MealDetailViewModel.swift
//  fetch
//
//  Created by Nguyen Vien on 8/13/24.
//

import Foundation

@MainActor
class MealDetailViewModel: ObservableObject {
    @Published private(set) var status = Status.notStarted
    @Published private(set) var mealDetail: MealModel!
    
    private let fetchController: FetchControllerProtocol
    
    init(fetchController: FetchControllerProtocol) {
        self.fetchController = fetchController
    }
    
    func fetchData(mealId: String) async {
        self.status = .fetching
        
        do {
            let data = try await fetchController.fetchMealDetail(mealId: mealId)
            if let data = data {
                self.mealDetail = data
            }
            status = .success
            
        }catch {
            self.status = .failed(error: error)
        }
    }
}
