//
//  RootScreen.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import SwiftUI

struct RootScreen: View {
    @EnvironmentObject var auth: Auth
    
    var body: some View {
        if auth.loggedIn {
            TabsView()
        } else {
            LoginScreen()
        }
    }
}

#Preview {
    RootScreen()
        .environmentObject(Auth.shared)
}
