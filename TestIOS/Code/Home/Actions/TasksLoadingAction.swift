//
//  TaskLoadingAction.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 12.11.2024.
//

import Foundation

struct TasksLoadingAction {
  var queryItems: [URLQueryItem]?
  let errorsByStatus = [
    400: NSLocalizedString("Invalid credentials", comment: "")
  ]

  func call(
    completion: @escaping ([TaskContainer]) -> Void,
    failure: @escaping (String) -> Void
  ) {
    APIRequest<EmptyRequest, [TaskContainer]>.call(
      path: "/get_tasks",
      method: .get,
      authorized: Auth.shared.loggedIn,
      queryItems: queryItems
    ) { data in
      if let response = try? JSONDecoder().decode([TaskContainer].self, from: data) {
        completion(response)
      } else {
        failure(NSLocalizedString("Failed to decode response", comment: ""))
      }
    } failure: { errorResult in
      failure(errorsByStatus[errorResult.status, default: errorResult.message])
    }
  }
}
