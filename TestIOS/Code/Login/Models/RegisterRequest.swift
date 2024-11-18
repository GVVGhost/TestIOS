//
//  RegisterRequest.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import Foundation

struct RegisterRequest: Encodable {
    let email: String
    let password: String
    let name: String
    let token: String
}
