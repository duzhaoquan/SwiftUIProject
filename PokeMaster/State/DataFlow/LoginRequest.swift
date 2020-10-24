//
//  LoginRequest.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/24.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import UIKit

import Combine

struct LoginRequest {
    
    var email :String
    var password:String
    
    var pulisher:AnyPublisher<User,AppError> {
        Future{ promise in
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.5) {
                if self.password == "password"{
                    let user = User(email: self.email, favoritePokemenIDs: [])
                    promise(.success(user))
                }
                else{
                    promise(.failure(AppError.passwordWrong))
                }
            }
            
        }.receive(on:DispatchQueue.main)
        .eraseToAnyPublisher()

    }
    

}
