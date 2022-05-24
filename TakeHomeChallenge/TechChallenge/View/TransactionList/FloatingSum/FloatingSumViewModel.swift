//
//  FloatingSumViewModel.swift
//  TechChallenge
//
//  Created by Alexandru Pop on 23/05/2022.
//

import SwiftUI

final class FloatingSumViewModel: ObservableObject {
    @Published var subtitleColor: Color
    @Published var subtitle: String
    @Published var totalValue: Double

    init(
        subtitle: String,
        subtitleColor: Color,
        totalValue: Double
    ) {
        self.subtitle = subtitle
        self.subtitleColor = subtitleColor
        self.totalValue = totalValue
    }
}
