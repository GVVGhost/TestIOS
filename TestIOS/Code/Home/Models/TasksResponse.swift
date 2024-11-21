//
//  TaskContainerRequest.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 12.11.2024.
//

import Foundation

struct TasksResponse: Hashable, Decodable {
  let tasks: [TaskContainer]
}

struct TaskContainer: Hashable, Codable {
  var createdAt: Int
  var updatedAt: Int
  var title: String
  var description: String
  var owner: TaskOwnerData
  var tasks: [TaskData]
  var uuid: String

  static func initEmpty(owner: TaskOwnerData) -> Self {
    return .init(
      createdAt: Int(Date().timeIntervalSince1970 * 1000),
      updatedAt: Int(Date().timeIntervalSince1970 * 1000),
      title: "",
      description: "",
      owner: owner,
      tasks: [],
      uuid: UUID().uuidString
    )
  }

  #if DEBUG
    static let examle: TaskContainer = .init(
      createdAt: 1_731_517_564_208,
      updatedAt: 1_731_678_511_600,
      title: "Training",
      description: "Create 3 apps with different languages/frameworks",
      owner: TaskOwnerData.examle,
      tasks: TaskData.examles,
      uuid: "a5747136-e1b8-4878-bbb2-342b224edfbb"
    )
  #endif
}

struct TaskData: Hashable, Codable {
  var place: Int
  var title: String
  var description: String
  var isComplete: Bool
  var color: String

  #if DEBUG
    static let examles: [TaskData] = [
      .init(
        place: 1,
        title: "React Native",
        description:
          "Create an app using the React Native framework for both Android and iOS devices",
        isComplete: true,
        color: "white"
      ),
      .init(
        place: 2,
        title: "SwiftUI",
        description:
          "Create an iOS app using Apple's own SwiftUI framework",
        isComplete: false,
        color: "white"
      ),
      .init(
        place: 3,
        title: "Android",
        description:
          "Create an Android app using Kotlin with Jetpack Compose",
        isComplete: false,
        color: "white"
      )
    ]
  #endif
}

struct TaskOwnerData: Hashable, Codable {
  let id: String
  let name: String

  #if DEBUG
    static let examle: TaskOwnerData = .init(
      id: "74c43a4c-0a6d-4f45-b16f-f1fece69c629",
      name: "Two Two"
    )
  #endif
}
