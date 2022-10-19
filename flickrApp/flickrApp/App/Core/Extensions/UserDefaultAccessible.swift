//
//  UserDefaultAccessible.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 18.10.2022.
//

import Foundation

protocol UserDefaultsAccessible {}

extension UserDefaultsAccessible {
    var defaults: UserDefaults {
        UserDefaults.standard
    }
    
    var uid: String? {
        stringDefault(for: .uid)
    }
    
    func stringDefault(for key: UserDefaultConstants) -> String? {
        defaults.string(forKey: key.rawValue)
    }
}
