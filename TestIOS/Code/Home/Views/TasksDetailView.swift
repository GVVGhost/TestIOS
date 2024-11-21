//
//  TaskDetailView.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 14.11.2024.
//

import SwiftUI

struct TasksDetailView: View {
  let taskContainer: TaskContainer
  var onDeleteContainer: (TaskContainer) -> Void
  var onSaveContainer: (TaskContainer) -> Void
  @State var containerTasks: [TaskData] = []
  @State var containerTitle: String = ""
  @State var containerDescription: String = ""
  @State var editableTask: EditableTask?
  @Environment(\.dismiss) var dismiss

  init(
    taskContainer: TaskContainer,
    onDeleteContainer: @escaping (TaskContainer) -> Void,
    onSaveContainer: @escaping (TaskContainer) -> Void
  ) {
    self.taskContainer = taskContainer
    self.containerTitle = taskContainer.title
    self.containerDescription = taskContainer.description
    self.onSaveContainer = onSaveContainer
    self.onDeleteContainer = onDeleteContainer
  }

  var body: some View {
    NavigationStack {
      Form {
        Section(header: Text("Title")) {
          TextField("Enter a title", text: $containerTitle)
            .font(.subheadline)
        }

        Section(header: Text("Description")) {
          TextField("Enter a title", text: $containerDescription, axis: .vertical)
            .font(.subheadline)
        }

        Section {
          HStack {
            Text("Add new task")
              .font(.subheadline)
            Spacer()
            Button {
              editableTask = EditableTask.initEmpty(at: (containerTasks.endIndex + 1))
            } label: {
              Image(systemName: "plus")
            }
          }
        }

        List {
          if !containerTasks.isEmpty {
            HStack {
              Image(systemName: "inset.filled.righthalf.arrow.right.rectangle")
              Text("Edit")
              Spacer()
              Text("Hold")
              Image(systemName: "checkmark.circle")
              Spacer()
              Text("Delete")
              Image(systemName: "inset.filled.lefthalf.arrow.left.rectangle")
            }
            .font(.system(size: 12))
            .foregroundStyle(.secondary)
          }

          ForEach(Array(containerTasks), id: \.place) { task in
            HStack(alignment: .center) {
              Text(task.place, format: .number)
                .font(.system(size: 16, weight: .bold))

              VStack(alignment: .leading) {
                Text(task.title)
                  .font(.system(size: 14, weight: .bold))
                Text(task.description)
              }

              Spacer()

              if task.isComplete == true {
                Image(systemName: "checkmark.circle")
                  .font(.system(size: 24))
                  .foregroundStyle(.green)
              }
            }
            .font(.system(size: 14))
            .swipeActions(edge: .trailing) {
              Button {
                deleteOne(place: task.place)
              } label: {
                Image(systemName: "trash")
              }
              .tint(.red)
            }
            .swipeActions(edge: .leading) {
              Button("Edit", systemImage: "pencil") {
                editableTask = EditableTask.initBasedOn(task)
              }
              .tint(.blue)
            }
            .onLongPressGesture {
              toggleCompleted(place: task.place)
            }
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .bottomBar) {
          Button {
            onDeleteContainer(taskContainer)
            dismiss()
          } label: {
            Text("Delete this group")
          }
        }

        ToolbarItem(placement: .primaryAction) {
          Button {
            saveAllChanges()
          } label: {
            Text("Save")
          }
        }

      }
      .sheet(item: $editableTask) { task in
        TaskSheetView(task: task, onSave: onReceiveTask, onDelete: deleteOne)
      }
      .onAppear {
        containerTitle = taskContainer.title
        containerDescription = taskContainer.description
        containerTasks = taskContainer.tasks
      }
    }
  }

  func saveAllChanges() {
    let timestamp = Int(Date().timeIntervalSince1970 * 1000)
    let container = TaskContainer.init(
      createdAt: timestamp,
      updatedAt: timestamp,
      title: containerTitle,
      description: containerDescription,
      owner: taskContainer.owner,
      tasks: containerTasks,
      uuid: taskContainer.uuid
    )
    onSaveContainer(container)
  }

  func deleteOne(place: Int) {
    containerTasks.removeAll(where: { $0.place == place })
  }

  func onReceiveTask(task: TaskData) {
    if let index = containerTasks.firstIndex(where: { $0.place == task.place }) {
      containerTasks[index] = task
    } else {
      containerTasks.append(task)
    }
  }

  func toggleCompleted(place: Int) {
    if let index = containerTasks.firstIndex(where: { $0.place == place }) {
      containerTasks[index].isComplete.toggle()
    }
  }
}

#Preview {
  TasksDetailView(
    taskContainer: TaskContainer.examle,
    onDeleteContainer: { taskContainer in
      print("Deleting \(taskContainer)")
    },
    onSaveContainer: { taskContainer in
      print("Saving \(taskContainer)")
    }
  )
}
