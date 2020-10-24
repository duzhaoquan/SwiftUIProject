//
//  AppError.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/24.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import UIKit

enum AppError:Error,Identifiable {
    var id :String{localizedDescription}
    
    case passwordWrong

}
extension AppError : LocalizedError{
    
    var localizedDescription: String{
        switch self {
        case .passwordWrong:
            return "密码错误"
        
        }
    }
}
