//
//  LoginAction.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import Foundation

struct LoginAction {
    let path = "/login"
    let method: HTTPMethod = .post
    var parameters: LoginRequest
    let errorsByStatus = [
        400: NSLocalizedString("Invalid credentials", comment: ""),
        403: NSLocalizedString("Incorrect password", comment: ""),
        404: NSLocalizedString("No user found with this email", comment: "")
    ]
    
    func call(
        completion: @escaping (LoginResponse) -> Void,
        failure: @escaping (String) -> Void
    ) {
        APIRequest<LoginRequest, LoginResponse>.call(
            path: path,
            method: .post,
            authorized: Auth.shared.loggedIn,
            parameters: parameters
        ) { data in
            if let response = try? JSONDecoder().decode(
                LoginResponse.self,
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
