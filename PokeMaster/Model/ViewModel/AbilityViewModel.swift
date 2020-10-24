//
//  AbilityViewModel.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/15.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import Foundation
import SwiftUI

struct AbilityViewModel: Identifiable {

    let ability: Ability

    init(ability: Ability) {
        self.ability = ability
    }

    var id: Int { ability.id }
    var name: String { ability.names.CN }
    var nameEN: String { ability.names.EN }
    var descriptionText: String { ability.flavorTextEntries.CN.newlineRemoved }
    var descriptionTextEN: String { ability.flavorTextEntries.EN.newlineRemoved }
    
   
}

extension AbilityViewModel: CustomStringConvertible {
    var description: String {
        "AbilityViewModel - \(id) - \(self.name)"
    }
}
