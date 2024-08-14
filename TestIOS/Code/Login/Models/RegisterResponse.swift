//
//  RegisterResponse.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

struct RegisterResponse: Decodable {
    let name: String
    let email: String
    let id: String
}
