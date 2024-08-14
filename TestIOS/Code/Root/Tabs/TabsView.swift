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
        //        .tint(.pink)
        .onAppear(perform: {
            // 2
            //            UITabBar.appearance().unselectedItemTintColor = .systemBrown
            // 3
            //            UITabBarItem.appearance().badgeColor = .systemPink
            // 4
            //            UITabBar.appearance().backgroundColor = .systemGray4.withAlphaComponent(0.4)
            // 5
            //            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.systemPink]
            // UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance()
            // Above API will kind of override other behaviour and bring the default UI for TabView
        })
    }
}

#Preview {
    TabsView()
}
