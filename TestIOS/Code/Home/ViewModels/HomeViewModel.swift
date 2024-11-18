//
//  HomeViewModel.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 07.08.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    @Published var toast: Toast?
    @Published var tasks: [TaskContainer] = []

    func logout() {
        Auth.shared.logout()
    }
    
    #if DEBUG
    func exampleTasks() {
        self.tasks = [TaskContainer.examle]
    }
    #endif

    func loadTasks() {
        if let id = Auth.shared.getUserId() {
            let query = URLQueryItem(name: "id", value: id)
            TaskLoadingAction(queryItems: [query]).call { response in
                DispatchQueue.main.async {
                    print(response.debugDescription)
                    self.tasks = response
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
        } else {
            self.toast = Toast(
                style: .error,
                message: "User id is missed",
                duration: 3,
                width: .infinity
            )
        }
    }
}
