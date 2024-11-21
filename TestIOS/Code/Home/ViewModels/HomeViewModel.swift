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

  #if DEBUG
    func exampleTasks() {
      self.taskContainers = [TaskContainer.examle]
    }
  #endif

  func loadTasks() {
    if let id = Auth.shared.getUserId() {
      let query = URLQueryItem(name: "id", value: id)
      TasksLoadingAction(queryItems: [query]).call { response in
        DispatchQueue.main.async {
          self.taskContainers = response
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
      notifyAboutMissingUserId()
    }
  }

  func updateTask(_ taskContainer: TaskContainer) {
    UpdateTaskAction(taskContainer: taskContainer).call { response in
      DispatchQueue.main.async {
        if let index = self.taskContainers.firstIndex(of: taskContainer) {
          self.taskContainers[index] = response
        }
      }
    } failure: { errorMessage in
      DispatchQueue.main.async {
        self.toast = Toast(
          style: .error,
          message: errorMessage,
          duration: 3,
          width: .infinity
        )
      }
    }
  }

  func createTask(_ taskContainer: TaskContainer) {
    CreateTaskAction(taskContainer: taskContainer).call { response in
      DispatchQueue.main.async {
        self.taskContainers.append(response)
      }
    } failure: { errorMessage in
      DispatchQueue.main.async {
        self.toast = Toast(
          style: .error,
          message: errorMessage,
          duration: 3,
          width: .infinity
        )
      }
    }
  }

  func deleteTask(_ uuid: String) {
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

  private func notifyAboutMissingUserId() {
    self.toast = Toast(
      style: .error,
      message: "User id is missed. Please relogin",
      duration: 3,
      width: .infinity
    )
  }
}
