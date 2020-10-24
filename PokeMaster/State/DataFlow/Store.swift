//
//  Store.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/22.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import UIKit
import Combine

class Store: ObservableObject {
    @Published var appState  = AppState()

    class func reduce(state:AppState,action:AppAction) -> (AppState,AppCommand?) {
        
        var appState = state
        var appCommand :AppCommand?
        switch action {
        case .login(let email, let password):

            appState.settings.loginRequesting = true
            appCommand = LoginAppCommand(email: email, password: password)
        case .accountBehaviorDone(let result):
            
            appState.settings.loginRequesting = false
            switch result {
            case  .success(let user):
                appState.settings.loginUser = user
            case .failure(let error):
                print("Error: \(error)")
                appState.settings.loginError = error
                
            }
        case .cleanCache:
            appState.settings.loginUser = nil
        case .toggleListSelection(let index):
            appState.pokemonList.expandingIndex = index
        }
        return (appState,appCommand)
    }
    
    func dispath(_ action:AppAction)  {
        #if DEBUG
        print("[ACTION]: \(action)")
        #endif
        let reduce = Store.reduce(state: appState, action: action)
        appState = reduce.0
        if let command = reduce.1 {
            #if DEBUG
            print("[COMMAND]: \(command)")
            #endif
            command.execute(in: self)
        }
        
    }
}

class DisposeBag {
    private var values: [AnyCancellable] = []
    func add(_ value: AnyCancellable) {
        values.append(value)
    }
}

extension AnyCancellable {
    func add(to bag: DisposeBag) {
        bag.add(self)
    }
}
