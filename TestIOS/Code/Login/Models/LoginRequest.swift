//
//  LoginRequest.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import Foundation

struct LoginRequest: Encodable {
    let email: String
    let password: String
}
