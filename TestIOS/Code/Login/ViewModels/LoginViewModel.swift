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
  @Published var token: String = ""
  @Published var toast: Toast?

  func login() {
    LoginAction(parameters: LoginRequest(email: email, password: password))
      .call { response in
        self.setCredentials(response: response)
      } failure: { error in
        self.setToast(message: error)
      }
  }

  func register() {
    RegisterAction(parameters: RegisterRequest(email: email, password: password, name: name, token: token))
      .call { response in
        self.setCredentials(response: response)
      } failure: { error in
        self.setToast(message: error)
      }
  }
  
  private func setCredentials(response: AuthResponse) {
    DispatchQueue.main.async {
      Auth.shared.setCredentials(id: response.id, email: response.email, name: response.name, token: response.token)
    }
  }

  private func setToast(message: String, style: ToastStyle = .error) {
    DispatchQueue.main.async {
      self.toast = Toast(style: style, message: message, duration: 3, width: .infinity)
    }
  }
}
