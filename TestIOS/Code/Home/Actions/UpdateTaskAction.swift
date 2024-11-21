//
//  UpdateTaskAction.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 18.11.2024.
//

import Foundation

struct UpdateTaskAction {
  var taskContainer: TaskContainer
  let errorsByStatus = [
    400: NSLocalizedString("Invalid credentials", comment: "")
  ]

  func call(
    completion: @escaping (TaskContainer) -> Void,
    failure: @escaping (String) -> Void
  ) {
    APIRequest<TaskContainer, TaskContainer>.call(
      path: "/update_task",
      method: .put,
      authorized: Auth.shared.loggedIn,
      parameters: taskContainer
    ) { data in
      print(data.debugDescription)
      if let response = try? JSONDecoder().decode(
        TaskContainer.self,
        from: data
      ) {
        completion(response)
      } else {
        print("Failed to decode response")
        failure(
          NSLocalizedString("Failed to decode response", comment: "")
        )
      }
    } failure: { errorResult in
      failure(
        errorsByStatus[
          errorResult.status,
          default: errorResult.message
        ]
      )
    }
  }
}
