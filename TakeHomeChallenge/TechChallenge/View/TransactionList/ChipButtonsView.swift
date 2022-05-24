//
//  ChipButtonsView.swift
//  TechChallenge
//
//  Created by Alexandru Pop on 22/05/2022.
//

import SwiftUI

struct ChipButtonsView: View {
    @State private(set) var buttonModels: [ChipButtonModel]

    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(buttonModels) { model in
                    Button {
                        model.onTap()
                    } label: {
                        Text(model.title)
                            .padding(.horizontal)
                            .padding(.vertical, 4)
                            .font(.title2.bold())
                            .foregroundColor(.white)
                            .background(model.backgroundColor)
                            .clipShape(Capsule())
                    }
                }
            }
            .padding()
        }
    }
}

struct ChipButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ChipButtonsView(
            buttonModels: [
                .init(
                    title: "Test",
                    backgroundColor: .blue,
                    onTap: { print("Test tapped" )}
                )
            ]
        )
    }
}

struct ChipButtonModel: Identifiable {
    var id: String { title }

    let title: String
    let backgroundColor: Color
    let onTap: () -> Void
}
