//
//  TransactionView.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 27/7/21.
//

import SwiftUI

struct TransactionView: View {
    @ObservedObject private(set) var displayItem: TransactionDisplayItem

    private var transaction: TransactionModel {
        displayItem.transaction
    }

    var body: some View {
        VStack {
            HStack {
                Text(transaction.category.rawValue)
                    .font(.headline)
                    .foregroundColor(transaction.category.color)
                Spacer()
                Button(action: {
                    displayItem.isPinned.toggle()
                }) {
                    if displayItem.isPinned {
                        Image(systemName: "pin.fill")
                    } else {
                        Image(systemName: "pin.slash.fill")
                    }
                }
            }
            if displayItem.isPinned {
                HStack {
                    transaction.image
                        .resizable()
                        .frame(
                            width: 60.0,
                            height: 60.0,
                            alignment: .top
                        )

                    VStack(alignment: .leading) {
                        Text(transaction.name)
                            .secondary()
                        Text(transaction.accountName)
                            .tertiary()
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("$\(transaction.amount.formatted())")
                            .bold()
                            .secondary()
                        Text(transaction.date.formatted)
                            .tertiary()
                    }
                }
            }
        }
        .padding(8.0)
        .background(Color.accentColor.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 8.0))
    }
}

#if DEBUG
struct TransactionView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            TransactionView(displayItem: .init(transaction: ModelData.sampleTransactions[0]))
            TransactionView(displayItem: .init(transaction: ModelData.sampleTransactions[1]))
        }
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
#endif
