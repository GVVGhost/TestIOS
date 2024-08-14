//
//  ContentView.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 13.08.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RootScreen()
            .environmentObject(Auth.shared)
    }
}

#Preview {
    ContentView()
}
