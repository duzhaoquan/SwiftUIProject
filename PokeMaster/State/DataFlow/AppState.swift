//
//  AppState.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/22.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import Foundation
struct AppState {
    var settings = Settings()
    var pokemonList = PokemonList()
}

extension AppState {
    
    struct PokemonList {
        var expandingIndex : Int?
    }
    
    struct Settings {
        @FileStorage(fileName: "user.json", directory: FileManager.SearchPathDirectory.documentDirectory)
        var loginUser : User? 
        enum Sorting : Int, CaseIterable {
            case id, name, color, favorite
        }
        //排序依据
        @UserDefaultsSortingStorage(key: "sorting")
        var sorting : Sorting
        //是否显示name
        @UserDefaultsBoolStorage(key: "showEnglishName")
        var showEnglishName :Bool
        //是否显示喜欢
        @UserDefaultsBoolStorage(key: "showFavoriteOnly")
        var showFavoriteOnly:Bool
        
        enum AccountBehavior: CaseIterable {
               
            case register, login
        }
        var accountBehavior:AccountBehavior = AccountBehavior.login
        var email = ""
        var password = ""
        var verifyPassword = ""
        var loginRequesting: Bool = false
        var loginError:AppError?
        
    }
}
extension AppState.Settings.Sorting {
    var text:String {
        switch self {
        case .id:
            return "ID"
        case .name:
            return "名字"
        case .color:
            return "颜色"
        case .favorite:
            return "最爱"
            
        }
    }
    
}
extension AppState.Settings.AccountBehavior {
    var text: String {
        switch self {
            case .register: return "注册"
            case .login: return "登录"
        }
    }
}
