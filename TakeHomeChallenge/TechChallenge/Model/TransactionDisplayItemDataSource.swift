//
//  TransactionDisplayItemDataSource.swift
//  TechChallenge
//
//  Created by Alexandru Pop on 24/05/2022.
//

import Foundation
import Combine
import SwiftUI

final class TransactionDisplayItemDataSource: ObservableObject {
    let items: [TransactionDisplayItem]
    @Published var pinnedTransactions = [TransactionDisplayItem]()

    init(
        items: [TransactionDisplayItem]
    ) {
        self.items = items
        bindBehaviours()
    }

    convenience init() {
        self.init(items: ModelData.sampleTransactions.map { TransactionDisplayItem(transaction: $0) })
    }
}

private extension TransactionDisplayItemDataSource {
    func bindBehaviours() {
        Publishers
            .MergeMany(items.map(\.objectDidChange))
            .compactMap { [weak self] _ in
                self?.items.filter(\.isPinned)
            }
            .assign(to: &$pinnedTransactions)
    }
}

final class TransactionDisplayItem: ObservableObject, Identifiable {
    let transaction: TransactionModel
    @Published var isPinned: Bool = false {
        didSet {
            objectDidChange.send()
        }
    }
    let objectDidChange = ObservableObjectPublisher()

    init(transaction: TransactionModel) {
        self.transaction = transaction
    }
}
