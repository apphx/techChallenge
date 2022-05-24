//
//  FloatingSumView.swift
//  TechChallenge
//
//  Created by Alexandru Pop on 22/05/2022.
//

import SwiftUI

struct FloatingSumView: View {
    private enum Constants {
        enum Overlay {
            static let cornerRadius: CGFloat = 8
            static let strokeColor: Color = .accentColor
            static let lineWidth: CGFloat = 2
        }
    }

    @ObservedObject private(set) var viewModel: FloatingSumViewModel

    var body: some View {
        VStack {
            Text(viewModel.subtitle)
                .foregroundColor(viewModel.subtitleColor)
                .font(.system(.headline))
                .frame(maxWidth: .infinity, alignment: .trailing)
            HStack {
                Text("Total spent:")
                    .secondary()
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(viewModel.totalValue as NSNumber, formatter: .currency)
                    .bold()
                    .secondary()
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: Constants.Overlay.cornerRadius)
                .stroke(Constants.Overlay.strokeColor, lineWidth: Constants.Overlay.lineWidth)
        )
    }
}

struct FloatingSumView_Previews: PreviewProvider {
    static var previews: some View {
        FloatingSumView(
            viewModel: FloatingSumViewModel(
                subtitle: "Some subtitle",
                subtitleColor: .accentColor,
                totalValue: 123_456
            )
        )
    }
}
