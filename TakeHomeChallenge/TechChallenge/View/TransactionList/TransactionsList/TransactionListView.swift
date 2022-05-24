//
//  TransactionListView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionListView: View {
    private enum Constants {
        static let floatingSumPadding: CGFloat = 8
        static let chipButtonsBackgroundColor = Color.accentColor.opacity(0.8)
    }
    @ObservedObject private var viewModel: TransactionListViewModel

    init(viewModel: TransactionListViewModel) {
        self.viewModel = viewModel
    }

    var body: some View {
        VStack {
            ChipButtonsView(buttonModels: viewModel.chipButtonModels)
                .background(Constants.chipButtonsBackgroundColor)
            List(viewModel.transactions) { transaction in
                TransactionView(displayItem: transaction)
            }
            .animation(.easeIn)
            .listStyle(PlainListStyle())
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Transactions")
            FloatingSumView(viewModel: viewModel.floatingSumModel)
                .padding(Constants.floatingSumPadding)
        }
    }
}

#if DEBUG
struct TransactionListView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionListView(
            viewModel: TransactionListViewModel(
                dataSource: TransactionDisplayItemDataSource(
                    items: [.init(transaction: ModelData.sampleTransactions[0])]
                )
            )
        )
    }
}
#endif
