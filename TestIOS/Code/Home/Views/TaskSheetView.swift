//
//  TaskSheetView.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 18.11.2024.
//

import SwiftUI

struct TaskSheetView: View {
  var task: EditableTask
  var onSave: (TaskData) -> Void
  var onDelete: (Int) -> Void
  @Environment(\.dismiss) var dismiss
  @State var isCompleted: Bool = false
  @State var title: String = ""
  @State var description: String = ""

  init(
    task: EditableTask,
    onSave: @escaping (TaskData) -> Void,
    onDelete: @escaping (Int) -> Void
  ) {
    self.task = task
    self.onSave = onSave
    self.onDelete = onDelete
  }

  var body: some View {
    NavigationStack {
      VStack {
        Form {
          Section(header: Text("Title")) {
            TextField("Enter a title", text: $title)
          }

          Section(header: Text("Description")) {
            TextField("Enter a description", text: $description)
          }

          Section(header: Text("Set completion marking")) {
            Toggle("Completed", isOn: $isCompleted)
          }
        }
      }
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") { dismiss() }
        }

        ToolbarItem(placement: .primaryAction) {
          Button("Save") {
            onSave(buildTasks())
            dismiss()
          }
        }

        ToolbarItem(placement: .bottomBar) {
          Button("Delete this task") {
            onDelete(task.place)
            dismiss()
          }
        }
      }
    }
    .onAppear {
      title = task.title
      description = task.description
      isCompleted = task.isComplete
    }
  }

  func buildTasks() -> TaskData {
    return .init(
      place: task.place,
      title: title,
      description: description,
      isComplete: task.isComplete,
      color: task.color
    )
  }
}

#Preview {
  TaskSheetView(
    task: .init(
      id: UUID(),
      place: 1,
      title: "Title",
      description: "Description",
      isComplete: false,
      color: "white"
    ),
    onSave: { _ in },
    onDelete: { _ in }
  )
}
