//
//  NetworkMonitor.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import Foundation
import Network

class NetworkMonitor {
  static let shared: NetworkMonitor = NetworkMonitor()

  let monitor = NWPathMonitor()
  private var status: NWPath.Status = .requiresConnection
  var isReachable: Bool { status == .satisfied }

  func startMonitoring() {
    monitor.pathUpdateHandler = { path in
      self.status = path.status
    }

    let queue = DispatchQueue(label: "Monitor")
    monitor.start(queue: queue)
  }

  func stopMonitoring() {
    monitor.cancel()
  }
}
