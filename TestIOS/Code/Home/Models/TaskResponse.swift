//
//  TaskContainerRequest.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 12.11.2024.
//

import Foundation

struct TaskResponse: Hashable, Decodable {
    let tasks: [TaskContainer]
}

struct TaskContainer: Hashable, Decodable {
    let createdAt: Int
    let updatedAt: Int
    let title: String
    let description: String
    let owner: TaskOwnerData
    let tasks: [TaskData]
    let uuid: String

    #if DEBUG
        static let examle: TaskContainer = .init(
            createdAt: 1731517564208,
            updatedAt: 1731678511600,
            title: "Training",
            description: "Create 3 apps with different languages/frameworks",
            owner: TaskOwnerData.examle,
            tasks: TaskData.examles,
            uuid: "a5747136-e1b8-4878-bbb2-342b224edfbb"
        )
    #endif
}

struct TaskData: Hashable, Decodable {
    let place: Int
    let title: String
    let description: String
    let isComplete: Bool
    let color: String

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

struct TaskOwnerData: Hashable, Decodable {
    let id: String
    let name: String

    #if DEBUG
        static let examle: TaskOwnerData = .init(
            id: "74c43a4c-0a6d-4f45-b16f-f1fece69c629",
            name: "Two Two"
        )
    #endif
}

struct EditableTask: Identifiable {
    let id: UUID
    let place: Int
    let title: String
    let description: String
    let isComplete: Bool
    let color: String
}
