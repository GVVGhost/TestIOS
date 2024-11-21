//
//  ContainerSheetView.swift
//  TestIOS
//
//  Created by Vadym Horeniuck on 19.11.2024.
//

import SwiftUI

struct ContainerSheetView: View {
  var onCreate: (TaskContainer) -> Void
  var onFailed: (String) -> Void
  @Environment(\.dismiss) var dismiss
  @State var title: String = ""
  @State var description: String = ""

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
        }
      }
      .toolbar {
        ToolbarItem(placement: .cancellationAction) {
          Button("Cancel") { dismiss() }
        }

        ToolbarItem(placement: .primaryAction) {
          Button("Save") { creteContainer() }
        }
      }
    }
  }

  func creteContainer() {
    let credentials = Auth.shared.getCredentials()
    if credentials.id != nil && credentials.name != nil {
      let timestamp = Int(Date().timeIntervalSince1970 * 1000)
      let container = TaskContainer.init(
        createdAt: timestamp,
        updatedAt: timestamp,
        title: title,
        description: description,
        owner: .init(id: credentials.id!, name: credentials.name!),
        tasks: [],
        uuid: UUID().uuidString
      )
      onCreate(container)
    } else {
      onFailed("Erorr. Missing user credentials. Relogin required.")
    }
    dismiss()
  }
}

#Preview {
  ContainerSheetView(onCreate: {_ in}, onFailed: {_ in}, title: "", description: "")
}
