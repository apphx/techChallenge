//
//  InsightsView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 29/7/21.
//

import SwiftUI

struct InsightsView: View {
    @ObservedObject private(set) var dataSource: TransactionDisplayItemDataSource
    
    var body: some View {
        List {
            RingView(transactions: $dataSource.pinnedTransactions)
                .scaledToFit()
            
            ForEach(TransactionModel.Category.allCases) { category in
                HStack {
                    Text(category.rawValue)
                        .font(.headline)
                        .foregroundColor(category.color)
                    Spacer()
                    Text(
                        (
                            dataSource.pinnedTransactions.filterByCategory(category).sumOfAmounts()
                            as NSNumber
                        )
                        , formatter: .currency
                    )
                        .bold()
                        .secondary()
                }
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Insights")
    }
}

#if DEBUG
struct InsightsView_Previews: PreviewProvider {
    static var previews: some View {
        InsightsView(dataSource: .init())
            .previewLayout(.sizeThatFits)
    }
}
#endif
