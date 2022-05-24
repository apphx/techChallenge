//
//  TransactionsListViewModel.swift
//  TechChallenge
//
//  Created by Alexandru Pop on 22/05/2022.
//

import Combine
import SwiftUI

final class TransactionListViewModel: ObservableObject {
    @Published private(set) var transactions = [TransactionDisplayItem]()
    @Published var selectedCategory: TransactionModel.Category?
    private let dataSource: TransactionDisplayItemDataSource

    private(set) lazy var chipButtonModels = makeChipButtonModels()
    private(set) lazy var floatingSumModel = makeFloatingSumModel()

    private var cancellables = Set<AnyCancellable>()

    init(dataSource: TransactionDisplayItemDataSource) {
        self.dataSource = dataSource
        bindBehaviours()
    }
}

// MARK: - Behaviours

private extension TransactionListViewModel {
    func bindBehaviours() {
        $selectedCategory
            .removeDuplicates()
            .map(filteredTransactions)
            .assign(to: &$transactions)

        $selectedCategory
            .removeDuplicates()
            .map(titleFor)
            .assign(to: &floatingSumModel.$subtitle)

        $selectedCategory
            .removeDuplicates()
            .map(colorFor)
            .assign(to: &floatingSumModel.$subtitleColor)

        Publishers
            .CombineLatest($selectedCategory, dataSource.$pinnedTransactions)
            .map { (category, pinnedTransactions) in
                pinnedTransactions
                    .filterByCategory(category)
                    .sumOfAmounts()
            }
            .assign(to: &floatingSumModel.$totalValue)
    }

    func filteredTransactions(basedOn category: TransactionModel.Category?) -> [TransactionDisplayItem] {
        dataSource.items.filterByCategory(category)
    }
}

// MARK: - Models factory

private extension TransactionListViewModel {
    func makeFloatingSumModel() -> FloatingSumViewModel {
        FloatingSumViewModel(
            subtitle: titleFor(selectedCategory),
            subtitleColor: colorFor(selectedCategory),
            totalValue: 0
        )
    }

    func makeChipButtonModels() -> [ChipButtonModel] {
        let availableFilters: [TransactionModel.Category?] = [nil] + TransactionModel.Category.allCases
        return availableFilters.map { category in
            ChipButtonModel(
                title: titleFor(category),
                backgroundColor: colorFor(category)
            ) { [weak self] in
                self?.selectedCategory = category
            }
        }
    }

    func titleFor(_ category: TransactionModel.Category?) -> String {
        category?.rawValue ?? "all"
    }

    func colorFor(_ category: TransactionModel.Category?) -> Color {
        category?.color ?? .black
    }
}

extension Array where Element == TransactionDisplayItem {
    func filterByCategory(_ category: TransactionModel.Category?) -> [TransactionDisplayItem] {
        guard let category = category else {
            return self
        }
        return self.filter { $0.transaction.category == category }
    }

    func sumOfAmounts() -> Double {
        map(\.transaction.amount)
            .reduce(0, +)
    }

    func sumOfTransactionsFilteredByCategory(_ category: TransactionModel.Category) -> Double {
        filterByCategory(category).sumOfAmounts()
    }
}
