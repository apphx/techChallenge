//
//  InsightsViewModel.swift
//  TechChallenge
//
//  Created by Alexandru Pop on 24/05/2022.
//

import Foundation

final class InsightsViewModel: ObservableObject {

    var dataSource: TransactionDisplayItemDataSource

    init(dataSource: TransactionDisplayItemDataSource) {
        self.dataSource = dataSource
    }
}
