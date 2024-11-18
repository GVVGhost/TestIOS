//
//  TaskLoadingAction.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 12.11.2024.
//

import Foundation

struct TaskLoadingAction {
    var queryItems: [URLQueryItem]?
    let errorsByStatus = [
        400: NSLocalizedString("Invalid credentials", comment: "")
    ]

    func call(
        completion: @escaping ([TaskContainer]) -> Void,
        failure: @escaping (String) -> Void
    ) {
        print("getTasks called")
        APIRequest<EmptyRequest, [TaskContainer]>.call(
            path: "/get_tasks",
            method: .get,
            authorized: Auth.shared.loggedIn,
            queryItems: queryItems
        ) { data in
            if let response = try? JSONDecoder().decode(
                [TaskContainer].self,
                from: data
            ) {
                print(response)
                completion(response)
            } else {
                print("Failed to decode response")
                failure(
                    NSLocalizedString("Failed to decode response", comment: "")
                )
            }
        } failure: { errorResult in
            failure(
                errorsByStatus[errorResult.status, default: errorResult.message]
            )
        }
    }
}
