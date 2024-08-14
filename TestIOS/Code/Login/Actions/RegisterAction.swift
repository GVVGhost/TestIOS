//
//  RegisterAction.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 08.08.2024.
//

import Foundation

struct RegisterAction {
    let path = "/register"
    let method: HTTPMethod = .post
    var parameters: RegisterRequest
    let errorsByStatus = [
        400: NSLocalizedString("Invalid credentials", comment: ""),
        409: NSLocalizedString("User already exist", comment: "")
    ]
    
    func call(
        completion: @escaping (RegisterResponse) -> Void,
        failure: @escaping (String) -> Void
    ) {
        APIRequest<RegisterRequest, RegisterResponse>.call(
            path: path,
            method: .post,
            authorized: Auth.shared.loggedIn,
            parameters: parameters
        ) { data in
            if let response = try? JSONDecoder().decode(
                RegisterResponse.self,
                from: data
            ) {
                completion(response)
            } else {
                failure(NSLocalizedString("Failed to decode response", comment: ""))
            }
        } failure: { errorResult in
            failure(errorsByStatus[errorResult.status, default: errorResult.message])
        }
    }
}
