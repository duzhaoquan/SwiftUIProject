//
//  UserDefaultsStorage.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/31.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import Foundation
@propertyWrapper
struct UserDefaultsBoolStorage {
    let key :String
    var value :Bool
    
    init(key:String) {
        self.key = key
        self.value = UserDefaults.standard.bool(forKey: key)
    }
    var wrappedValue:Bool {
        set{
            value = newValue
            UserDefaults.standard.set(value, forKey: key)
        }
        get{
            value
        }
    }
    
    
}

@propertyWrapper
struct UserDefaultsSortingStorage {

    let key: String
    var value: AppState.Settings.Sorting
    
    init(key: String) {
        self.key = key
        value = AppState.Settings.Sorting(rawValue: UserDefaults.standard.integer(forKey: key)) ?? .id
    }
    
    var wrappedValue: AppState.Settings.Sorting {
        set {
            value = newValue
            UserDefaults.standard.set(value.rawValue, forKey: key)
        }
        get { value }
    }
}


