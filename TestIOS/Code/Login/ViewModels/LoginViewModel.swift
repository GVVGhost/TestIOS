//
//  LoginViewModel.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import Foundation

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var name: String = ""
    @Published var toast: Toast?
    
    func login() {
        LoginAction(
            parameters: LoginRequest(
                email: email,
                password: password
            )
        ).call { response in
            DispatchQueue.main.async {
                Auth.shared.setCredentials(
                    id: response.id,
                    email: response.email,
                    name: response.name
                )
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.toast = Toast(
                    style: .error,
                    message: error,
                    duration: 3,
                    width: .infinity
                )
            }
        }
    }
    
    func register() {
        RegisterAction(
            parameters: RegisterRequest(
                email: email,
                password: password,
                name: name
            )
        ).call { response in
            DispatchQueue.main.async {
                Auth.shared.setCredentials(
                    id: response.id,
                    email: response.email,
                    name: response.name
                )
            }
        } failure: { error in
            DispatchQueue.main.async {
                self.toast = Toast(
                    style: .error,
                    message: error,
                    duration: 3,
                    width: .infinity
                )
            }
        }
    }
}
