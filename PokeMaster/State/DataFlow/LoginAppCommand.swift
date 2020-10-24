//
//  LoginAppCommand.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/24.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import UIKit

protocol AppCommand {
    func execute(in store:Store)
}
let disposeBag: DisposeBag = DisposeBag()
struct LoginAppCommand:AppCommand {
    
    var email:String
    var password:String
    
    
    func execute(in store: Store) {
        _ = LoginRequest.init(email: email, password: password)
        .pulisher
            .sink(receiveCompletion: { (comp) in
                
                if case .failure(let err) = comp {
                    store.dispath(AppAction.accountBehaviorDone(result: .failure(err)))
                }
                
            }) { user in
                store.dispath(.accountBehaviorDone(result: .success(user)))
        }.add(to: disposeBag)
    }
    

}
