//
//  TechChallengeTests.swift
//  TechChallengeTests
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

@testable import TechChallenge
import XCTest

private typealias Category = TransactionModel.Category

final class TechChallengeTests: XCTestCase {

    let allCategoriesCount = Category.allCases.count

    func testFilteringTransactionsByCategory_whenCategoryIsNil_returnsTheFullArray()
    {
        let sut: [TransactionDisplayItem] = Array(
            repeating: TransactionDisplayItem(transaction: .sample(category: .food)),
            count: .random(in: 0..<100)
        )

        XCTAssertEqual(sut.filterByCategory(nil).map(\.transaction), sut.map(\.transaction))
    }
    
    func testFilteringTransactionsByCategory_whenCategoryIsNotNil_whenNoItemsWithCategoryArePresent_returnsEmptyArray()
    {
        let randomlyExcudedCategory = Category.allCases[Int.random(in: 0..<allCategoriesCount)]
        let sut: [TransactionDisplayItem] = Category
            .allCases
            .filter { $0 != randomlyExcudedCategory }
            .map { TransactionDisplayItem(transaction: .sample(category: $0)) }

        XCTAssertTrue(sut.filterByCategory(randomlyExcudedCategory).isEmpty)
    }

    func testFilteringTransactionsByCategory_whenCategoryIsNotNil_whenAtLeastOneItemWithCategoryIsPresent_returnsEquivalentItemArray()

    {
        let randomlyIncludedCategory = Category.allCases[Int.random(in: 0..<allCategoriesCount)]
        let randomlyIncludedCategoryItemsCount = Int.random(in: 0..<100)
        let sut = Category
            .allCases
            .map { category in
                Array(
                    repeating: TransactionModel.sample(category: category),
                    count: category == randomlyIncludedCategory ? randomlyIncludedCategoryItemsCount : Int.random(in: 0..<100)
                )
            }
            .flatMap { $0 }
            .map(TransactionDisplayItem.init)


        let expectedArray = Array(
            repeating: TransactionModel.sample(category: randomlyIncludedCategory),
            count: randomlyIncludedCategoryItemsCount
        )
        XCTAssertEqual(sut.filterByCategory(randomlyIncludedCategory).map(\.transaction), expectedArray)
    }

    func testSumOfFilteredTransactions_whenCategoryIsNotNil_whenNoItemsWithCategoryArePresent_returnsZero() {
        let randomlyExcudedCategory = Category.allCases[Int.random(in: 0..<allCategoriesCount)]
        let sut: [TransactionDisplayItem] = Category
            .allCases
            .filter { $0 != randomlyExcudedCategory }
            .map { TransactionDisplayItem(transaction: .sample(category: $0)) }

        XCTAssertEqual(sut.sumOfTransactionsFilteredByCategory(randomlyExcudedCategory), 0)
    }

    func testSumOfFilteredTransactions_whenCategoryIsNotNil_whenAtLeastOneItemWithCategoryIsPresent_returnsEquivalentItemArray()

    {
        let randomlyIncludedCategory = Category.allCases[Int.random(in: 0..<allCategoriesCount)]
        let randomlyIncludedCategoryItemsCount = Int.random(in: 0..<100)
        let sut = Category
            .allCases
            .map { category in
                Array(
                    repeating: TransactionModel.sample(category: category),
                    count: category == randomlyIncludedCategory ? randomlyIncludedCategoryItemsCount : Int.random(in: 0..<100)
                )
            }
            .flatMap { $0 }
            .map(TransactionDisplayItem.init)


        let expectedSum = Array(
            repeating: TransactionModel.sample(category: randomlyIncludedCategory),
            count: randomlyIncludedCategoryItemsCount
        )
            .map(\.amount)
            .reduce(0, +)
        XCTAssertEqual(sut.sumOfTransactionsFilteredByCategory(randomlyIncludedCategory), expectedSum)
    }

}

extension TransactionModel {
    static func sample (
        id: Int = 0,
        name: String = "TestName",
        category: TransactionModel.Category = .entertainment,
        amount: Double = 123_456,
        date: Date = Date(timeIntervalSince1970: 1234),
        accountName: String = "AccountName",
        provider: TransactionModel.Provider? = .amazon
    ) -> Self {
        .init(
            id: id,
            name: name,
            category: category,
            amount: amount,
            date: date,
            accountName: accountName,
            provider: provider
        )
    }
}
