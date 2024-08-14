//
//  HomeViewModel.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 07.08.2024.
//

import Foundation

class HomeViewModel: ObservableObject {
    
    func logout() {
        Auth.shared.logout()
    }
}
