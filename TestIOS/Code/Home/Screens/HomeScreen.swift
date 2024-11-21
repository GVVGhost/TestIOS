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
        ForEach(viewModel.taskContainers.reversed(), id: \.self) { taskContainer in
          NavigationLink {
            TasksDetailView(
              taskContainer: taskContainer,
              onDeleteContainer: { taskContainer in
                viewModel.deleteTaskContainer(taskContainer.uuid)
              },
              onSaveContainer: { taskContainer in
                viewModel.updateTaskContainer(taskContainer)
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
            viewModel.createTaskContainer(taskContainer)
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
      .onAppear { viewModel.loadTaskContainers() }
      .refreshable { viewModel.loadTaskContainers() }
      .toastView(toast: $viewModel.toast)
    }
  }
}

#Preview {
  HomeScreen()
}
