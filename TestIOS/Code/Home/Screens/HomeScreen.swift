//
//  HomeScreen.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 07.08.2024.
//

import SwiftUI

struct HomeScreen: View {
  @State private var toast: Toast?
  @ObservedObject var viewModel: HomeViewModel = HomeViewModel()
  @State var isPresented: Bool = false

  var body: some View {
    NavigationStack {
      List {
        ForEach(
          viewModel.taskContainers.reversed(),
          id: \.self
        ) { taskContainer in
          NavigationLink {
            TasksDetailView(
              taskContainer: taskContainer,
              onDeleteContainer: { taskContainer in
                viewModel.deleteTask(taskContainer.uuid)
              },
              onSaveContainer: { taskContainer in
                viewModel.updateTask(taskContainer)
              }
            )
          } label: {
            TaskListItemView(container: taskContainer)
          }
        }
      }
      .sheet(isPresented: $isPresented) {
        ContainerSheetView(
          onCreate: { taskContainer in
            viewModel.createTask(taskContainer)
          },
          onFailed: { errorMessage in
            toast = Toast(style: .error, message: errorMessage)
          }
        )
      }
      .toolbar {
        ToolbarItem(placement: .primaryAction) {
          Button {
            isPresented = true
          } label: {
            Image(systemName: "plus")
          }
        }
      }
      .onAppear {
        viewModel.loadTasks()
        #if DEBUG
          viewModel.taskContainers = [TaskContainer.examle]
        #endif
      }
      .refreshable {
        viewModel.loadTasks()
      }
      .toastView(toast: $viewModel.toast)
    }
  }
}

#Preview {
  HomeScreen()
}
