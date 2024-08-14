//
//  LoginScreen.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import SwiftUI

struct LoginScreen: View {
    @State private var toast: Toast?
    @State private var isRegisterMode: Bool = false
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    
    var body: some View {
        VStack {
            VStack {
                if isRegisterMode {
                    TextField("Name", text: $viewModel.name)
                        .modifier(RoundedStroke())
                        .disableAutocorrection(true)
                }
                TextField("Email", text: $viewModel.email)
                    .modifier(RoundedStroke())
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                
                SecureField("Password", text: $viewModel.password)
                    .modifier(RoundedStroke())
            }
            .frame(minHeight: 180)
            Button(
                action: isRegisterMode ? viewModel.register : viewModel.login,
                label: {
                    Text(isRegisterMode ? "Register" : "Log in")
                        .modifier(CustomButton())
                }
            )
            .padding(.vertical)
            Button(
                action: {
                    isRegisterMode.toggle()
                },
                label: {
                    Text(isRegisterMode ? "Return back" : "Or register")
                }
            )
        }
        .padding()
        .onReceive(viewModel.$toast) { toast in
            self.toast = toast
        }
        .toastView(toast: $toast)
    }
}

#Preview {
    LoginScreen()
}
