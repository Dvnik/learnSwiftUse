//
//  ContentView.swift
//  learnTest
//
//  Created by on 2024/1/30.
//

import SwiftUI
//預設的ContentView
struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
