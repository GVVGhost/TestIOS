//
//  EditableTask.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 19.11.2024.
//

import Foundation

struct EditableTask: Identifiable {
    var id: UUID
    var place: Int
    var title: String
    var description: String
    var isComplete: Bool
    var color: String
    
    static func initBasedOn(_ task: TaskData, at place: Int? = nil) -> Self {
        .init(
            id: UUID(),
            place: place ?? task.place,
            title: task.title,
            description: task.description,
            isComplete: task.isComplete,
            color: task.color
        )
    }
    
    static func initEmpty(at place: Int? = nil) -> Self {
        .init(
            id: UUID(),
            place: place ?? 1,
            title: "",
            description: "",
            isComplete: false,
            color: "white"
        )
    }
}
