//
//  SettingsScreen.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 09.08.2024.
//

import SwiftUI

struct SettingsScreen: View {
    @ObservedObject var viewModel: SettingsViewModel = SettingsViewModel()
    @State var toast: Toast?
    @State var dataList: [LabelValueModel] = []
    @State private var showAlert = false
    
    var body: some View {
        Form {
            if !dataList.isEmpty {
                Section(header: Text("User info")) {
                    ForEach(dataList, id: \.self) { element in
                        HStack(alignment: .firstTextBaseline) {
                            Image(systemName: "person.circle")
                            Text("\(element.label): \(element.value)")
                                .font(.system(size: 16, weight: .none, design: .default))
                            Spacer()
                        }
                    }
                }
            }
            Section(header: Text("Actions")) {
                Button {
                    showAlert = true
                } label: {
                    HStack {
                        Text("Log out")
                        Spacer()
                        Image(systemName: "rectangle.portrait.and.arrow.forward")
                    }
                }
                .alert("Log out?", isPresented: $showAlert) {
                    Button("Confirm") { viewModel.logout() }
                    Button("Cancel", role: .cancel) {}
                }
            }
        }
        .toastView(toast: $toast)
        .onReceive(viewModel.$dataList) { data in
            self.dataList = data
        }
    }
}

#Preview() {
    SettingsScreen()
}
