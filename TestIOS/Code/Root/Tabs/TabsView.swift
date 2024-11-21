//
//  TabsView.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 09.08.2024.
//

import SwiftUI

struct TabsView: View {
  @State private var selectedIndex: Int = 0

  var body: some View {
    TabView(selection: $selectedIndex) {
      NavigationStack {
        HomeScreen()
      }
      .tabItem {
        Text("Home")
        Image(systemName: "house.fill")
          .renderingMode(.template)
      }
      .tag(0)

      NavigationStack {
        SettingsScreen()
      }
      .tabItem {
        Text("Settings")
        Image(systemName: "gearshape.fill")
          .renderingMode(.template)
      }
      .tag(1)
    }
  }
}

#Preview {
  TabsView()
}
