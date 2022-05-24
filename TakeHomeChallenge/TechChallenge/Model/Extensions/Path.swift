//
//  Path.swift
//  TechChallenge
//
//  Created by Adrian Tineo Cabello on 30/7/21.
//

import SwiftUI

extension Path {
    init(offset: Double, ratio: Double, in rect: CGRect) {
        var path = Path()
        path.addArc(
            center: CGPoint(x: rect.midX, y: rect.midY),
            radius: (min(rect.width, rect.height) - 24) / 2,
            startAngle: .init(offset: offset, ratio: 0),
            endAngle: .init(offset: offset, ratio: ratio),
            clockwise: false
        )
        self = path
    }
}
