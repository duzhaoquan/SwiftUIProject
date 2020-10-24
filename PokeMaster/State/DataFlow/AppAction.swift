//
//  AppAction.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/24.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import UIKit
import Combine

enum AppAction {
    
    case toggleListSelection(index: Int?)
    
    case login(email:String,password:String)
    case accountBehaviorDone(result: Result<User, AppError>)
    case cleanCache
}
