//
//  TestIOSApp.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 13.08.2024.
//

import SwiftUI

@main
struct TestIOSApp: App {

  init() {
    NetworkMonitor.shared.startMonitoring()
  }

  var body: some Scene {
    WindowGroup {
      ContentView()
    }
  }
}
