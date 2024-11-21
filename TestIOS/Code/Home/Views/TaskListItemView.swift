//
//  TaskContainerView.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 14.11.2024.
//

import SwiftUI

struct TaskListItemView: View {
  let container: TaskContainer
  var formetedUpdatedAt: Date {
    Date(timeIntervalSince1970: TimeInterval(container.updatedAt / 1000))
  }

  var body: some View {
    VStack(alignment: .leading, spacing: 10) {
      HStack(alignment: .bottom) {
        Text(container.title)
          .font(.title2)
        Spacer()
        HStack(spacing: 5) {
          Image(systemName: "person")
          Text(container.owner.name)
        }
      }

      Text(container.description)
        .font(.subheadline)

      ForEach(Array(container.tasks.prefix(3)), id: \.place) { task in
        HStack(alignment: .firstTextBaseline) {
          Text(task.place, format: .number)

          VStack(alignment: .leading) {
            Text("\(task.title) \(task.isComplete ? "(completed)" : "")")
              .font(.system(size: 14, weight: task.isComplete ? .regular : .semibold))
            Text(task.description)
          }
        }
        .font(.system(size: 14))
      }
      if container.tasks.count > 3 {
        Text("...")
      }

      Text("Last edit: \(formetedUpdatedAt, format: .dateTime)")
        .font(.system(size: 14, weight: .light))
    }
  }
}

#Preview {
  TaskListItemView(container: .examle)
}
