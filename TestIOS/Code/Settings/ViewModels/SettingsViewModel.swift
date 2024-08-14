//
//  SettingsViewModel.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 09.08.2024.
//

import Foundation

class SettingsViewModel: ObservableObject {
    @Published var userData: UserData?
    @Published var dataList: [LabelValueModel] = []
    
    init() {
        getUserData()
    }
    
    func logout() {
        Auth.shared.logout()
    }
    
    func getUserData() {
        let defaults = UserDefaults.standard
        if let savedData = defaults.object(forKey: "userData") as? Data {
            let decoder = JSONDecoder()
            if let data = try? decoder.decode(UserData.self, from: savedData) {
                dataList.append(LabelValueModel(label: NSLocalizedString("User name", comment: ""), value: data.name))
                dataList.append(LabelValueModel(label: NSLocalizedString("User email", comment: ""), value: data.email))
                dataList.append(LabelValueModel(label: NSLocalizedString("User id", comment: ""), value: data.id))
            }
        }
    }
}
