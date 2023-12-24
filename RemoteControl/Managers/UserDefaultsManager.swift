//
//  UserDefaultsManager.swift
//  RemoteControl
//
//  Created by Akın Özcan on 15.12.2023.
//

import Foundation

enum UserDefaultsKey: String {
    case sliderHeight = "sliderHeight"
    case lastDragValue = "lastDragValue"

    var value: String {
        return self.rawValue
    }
}

class UserDefaultsManager {

    static let shared = UserDefaultsManager()

    private let userDefaults = UserDefaults.standard
    private init() { }

    func set<T>(_ obj: T, for key: UserDefaultsKey) {
        userDefaults.set(obj, forKey: key.value)
        userDefaults.synchronize()
    }

    func get(for key: UserDefaultsKey) -> Any? {
        let result = userDefaults.object(forKey: key.value)
        return result
    }
}
