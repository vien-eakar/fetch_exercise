//
//  MealListView.swift
//  fetch
//
//  Created by Nguyen Vien on 8/13/24.
//

import SwiftUI

struct MealListView: View {
    @StateObject var mealListViewModel = MealListViewModel(fetchController: FetchController())
    
    @State var alphabetical: Bool = true
    
    var body: some View {
        NavigationStack {
            switch mealListViewModel.status {
                case .success :
                    List {
                        ForEach(self.mealListViewModel.listMeals) { meal in
                            NavigationLink {
                                MealDetailView(mealId: meal.mealId)
                            } label: {
                                HStack {
                                    AsyncImage(url: meal.mealImage) { img in
                                        img.resizable()
                                            .scaledToFit()
                                    }placeholder: {
                                        ProgressView()
                                    }
                                    .frame(width: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, height: 100)
                                    .clipShape(.rect(cornerSize: CGSize(width: 5, height: 5)))
                                    
                                    Text(meal.mealName)
                                        .padding(.leading)
                                }
                            }
                        }
                    }
                    .navigationTitle("Dessert")
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button {
                                withAnimation {
                                    self.alphabetical.toggle()
                                    self.mealListViewModel.sortList(alphabetical: self.alphabetical)
                                }
                            } label: {
                                Image(systemName: self.alphabetical ? "textformat" : "film")
                                    .symbolEffect(.bounce, value: self.alphabetical)
                            }
                        }
                    }
                default:
                    ProgressView()
            }
        }
        .task {
            await mealListViewModel.fetchMeal(category: "Dessert")
        }
    }
}

#Preview {
    MealListView()
}
