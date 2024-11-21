//
//  HomeViewModel.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 07.08.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
  @Published var toast: Toast?
  @Published var taskContainers: [TaskContainer] = []

  func logout() {
    Auth.shared.logout()
  }

  func loadTaskContainers() {
    if let id = Auth.shared.getUserId() {
      let query = URLQueryItem(name: "id", value: id)
      TasksLoadingAction(queryItems: [query]).call { response in
        DispatchQueue.main.async {
          self.taskContainers = response
        }
      } failure: { error in
        self.setToast(message: error)
      }
    } else {
      self.setToast(message: "User id is missed. Please relogin")
    }
  }

  func updateTaskContainer(_ taskContainer: TaskContainer) {
    UpdateTaskAction(taskContainer: taskContainer).call { response in
      DispatchQueue.main.async {
        if let index = self.taskContainers.firstIndex(of: taskContainer) {
          self.taskContainers[index] = response
        }
      }
    } failure: { error in
      self.setToast(message: error)
    }
  }

  func createTaskContainer(_ taskContainer: TaskContainer) {
    CreateTaskAction(taskContainer: taskContainer).call { response in
      DispatchQueue.main.async {
        self.taskContainers.append(response)
      }
    } failure: { error in
      self.setToast(message: error)
    }
  }

  func deleteTaskContainer(_ uuid: String) {
    let query = URLQueryItem(name: "uuid", value: uuid)
    TaskDeleteAction(queryItems: [query]).call { response in
      DispatchQueue.main.async {
        if let id = response.first?.uuid {
          if let index = self.taskContainers.firstIndex(where: { $0.uuid == id }) {
            self.taskContainers.remove(at: index)
          }
        }
      }
    } failure: { error in
      self.setToast(message: error)
    }
  }

  private func setToast(message: String, style: ToastStyle = .error) {
    DispatchQueue.main.async {
      self.toast = Toast(style: style, message: message, duration: 3, width: .infinity)
    }
  }
}
