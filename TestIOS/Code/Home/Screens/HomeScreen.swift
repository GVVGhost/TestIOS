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

    var body: some View {
        NavigationStack {
            List(viewModel.tasks, id: \.uuid) { task in
                NavigationLink(value: task) {
                    TaskListItemView(container: task)
                }
            }
            .navigationDestination(for: TaskContainer.self) { task in
                TasksDetailView(taskContainer: task)
            }
        }
        .toastView(toast: $toast)
        .onAppear {
            viewModel.loadTasks()
        }
        .refreshable {
            viewModel.loadTasks()
        }

        #if DEBUG
            Button("Reload") {
                viewModel.exampleTasks()
            }
        #endif
    }
}

#Preview {
    HomeScreen()
}
