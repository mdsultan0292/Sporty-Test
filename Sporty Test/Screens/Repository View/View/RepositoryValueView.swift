//
//  RepositoryValueView.swift
//  Sporty Test
//
//  Created by Mohd Sultan on 7/7/26.
//

import SwiftUI

struct RepositoryValueView<Value: View>: View {
    let key: String
    let value: Value

    var body: some View {
        VStack(alignment: .leading) {
            Text(key)
                .font(.headline)
            value
        }
    }

    init(key: String, @ViewBuilder value: () -> Value) {
        self.key = key
        self.value = value()
    }
}
