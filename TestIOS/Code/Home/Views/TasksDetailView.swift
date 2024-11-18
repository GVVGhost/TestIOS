//
//  TaskDetailView.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 14.11.2024.
//

import SwiftUI

struct TasksDetailView: View {
    let taskContainer: TaskContainer
    @State var title: String = ""
    @State var description: String = ""
    @State var tasks: [TaskData] = []
    @State var editableTask: EditableTask?
    @State var isPresented = false

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter a title", text: $title)
                        .font(.subheadline)
                }

                Section(header: Text("Description")) {
                    TextField(
                        "Enter a title",
                        text: $description,
                        axis: .vertical
                    )
                    .font(.subheadline)
                }

                Section {
                    HStack {
                        Text("Add new task")
                            .font(.subheadline)
                        Spacer()
                        Button {
                            editableTask = .init(
                                id: UUID(),
                                place: tasks.count + 1,
                                title: title,
                                description: description,
                                isComplete: false,
                                color: "white"
                            )
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                }

                List {
                    ForEach(Array(tasks), id: \.place) { task in
                        HStack(alignment: .firstTextBaseline) {
                            Text(task.place, format: .number)
                            VStack(alignment: .leading) {
                                Text(task.title)
                                    .font(.system(size: 14, weight: .bold))
                                Text(task.description)
                            }
                        }
                        .font(.system(size: 14))
                        .swipeActions(edge: .trailing) {
                            Button {
                                deleteOne(task: task)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading) {
                            Button("Edit", systemImage: "pencil") {
                                editableTask = .init(
                                    id: UUID(),
                                    place: task.place,
                                    title: task.title,
                                    description: task.description,
                                    isComplete: task.isComplete,
                                    color: task.color
                                )
                            }
                            .tint(.blue)
                        }
                    }
                }
            }
        }
        .onAppear {
            title = taskContainer.title
            description = taskContainer.description
            tasks = taskContainer.tasks
        }
        .sheet(item: $editableTask) { task in
            Text(task.title)
        }
    }

    func saveAllChanges() {

    }

    func deleteOne(task: TaskData) {
        tasks.removeAll(where: { $0 == task })
    }

    func onReceiveTask(task: TaskData) {
        if let index = tasks.firstIndex(of: task) {
            tasks[index] = task
        } else {
            tasks.append(task)
        }
    }
}

#Preview {
    TasksDetailView(taskContainer: .examle)
}
