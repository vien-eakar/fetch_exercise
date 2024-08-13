//
//  MealDetailView.swift
//  fetch
//
//  Created by Nguyen Vien on 8/13/24.
//

import SwiftUI

struct MealDetailView: View {
    @StateObject var mealDetailViewModel = MealDetailViewModel(fetchController: FetchController())
    
    let mealId: String
    
    var body: some View {
        GeometryReader { geo in
            switch mealDetailViewModel.status {
                case .success:
                    ScrollView {
                        VStack (alignment: .leading) {
                            AsyncImage(url: mealDetailViewModel.mealDetail.mealImage) { image in
                                image.resizable()
                                    .scaledToFit()
                                
                            } placeholder: {
                                ProgressView()
                            }.frame(width: geo.size.width)
                                .clipShape(.rect(cornerSize: CGSize(width: 10, height: 10)))
                            
                            Text("Instructions".capitalized)
                                .font(.title)
                                .bold()
                            Text(mealDetailViewModel.mealDetail.instructions)
                                .padding(.bottom)
                            
                            Text("Ingredients/measurements".capitalized)
                                .font(.title)
                                .bold()
                            VStack(alignment: .leading) {
                                ForEach( 0..<self.mealDetailViewModel.mealDetail.ingredients.count, id: \.self) { idx in
                                    HStack{
                                        Text(self.mealDetailViewModel.mealDetail.ingredients[safeIndex: idx] ?? "")
                                            .bold()
                                        Text(":")
                                        Text(self.mealDetailViewModel.mealDetail.measures[safeIndex: idx] ?? "")
                                    }
                                }
                            } 
                        }
                    }
                    .navigationTitle(self.mealDetailViewModel.mealDetail.mealName)
                default: ProgressView()
            }
        }.task {
            await mealDetailViewModel.fetchData(mealId: mealId)
        }
        .padding()
    }
}

#Preview {
    MealDetailView(mealId: "52916")
}
