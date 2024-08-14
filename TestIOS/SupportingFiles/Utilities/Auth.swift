//
//  Auth.swift
//  MyTestApp
//
//  Created by Vadym Horeniuck on 06.08.2024.
//

import Foundation
import SwiftKeychainWrapper

class Auth: ObservableObject {
    
    struct Credentials {
        var id: String?
        var email: String?
        var name: String?
    }
    
    enum KeychainKey: String {
        case id
        case email
        case name
    }
    
    static let shared: Auth = Auth()
    private let keychain: KeychainWrapper = KeychainWrapper.standard
    
    @Published var loggedIn: Bool = false
    
    private init() {
        loggedIn = hasId()
    }
    
    func getCredentials() -> Credentials {
        return Credentials(
            id: keychain.string(forKey: KeychainKey.id.rawValue),
            email: keychain.string(forKey: KeychainKey.email.rawValue),
            name: keychain.string(forKey: KeychainKey.name.rawValue)
        )
    }
    
    func setCredentials(
        id: String,
        email: String,
        name: String
    ) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(UserData(name: name, email: email, id: id)) {
            let defaults = UserDefaults.standard
            defaults.set(encoded, forKey: "userData")
        }
        keychain.set(id, forKey: KeychainKey.id.rawValue)
        keychain.set(email, forKey: KeychainKey.email.rawValue)
        keychain.set(name, forKey: KeychainKey.name.rawValue)
        loggedIn = true
    }
    
    func hasId() -> Bool {
        return getCredentials().id != nil
    }
    
    func getAccessToken() -> String? {
        return getCredentials().id
    }
    
    func logout() {
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.id.rawValue)
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.email.rawValue)
        KeychainWrapper.standard.removeObject(forKey: KeychainKey.name.rawValue)
        loggedIn = false
    }
}