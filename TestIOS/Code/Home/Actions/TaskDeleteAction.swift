//
//  TaskDeleteAction.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 19.11.2024.
//

import Foundation

struct TaskDeleteAction {
  var queryItems: [URLQueryItem]?
  let errorsByStatus = [
    400: NSLocalizedString("Invalid credentials", comment: "")
  ]

  func call(
    completion: @escaping ([TaskContainer]) -> Void,
    failure: @escaping (String) -> Void
  ) {
    APIRequest<EmptyRequest, [TaskContainer]>.call(
      path: "/delete_task",
      method: .delete,
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
