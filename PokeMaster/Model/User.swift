//
//  User.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/22.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import UIKit

class User: Codable {

    var email: String

    var favoritePokemenIDs: Set<Int>
    
    func isFavoritePokemon(id: Int) -> Bool {
        favoritePokemenIDs.contains(id)
    }
    init(email: String,favoritePokemenIDs:Set<Int>) {
        self.email = email
        self.favoritePokemenIDs = favoritePokemenIDs
    }
}
