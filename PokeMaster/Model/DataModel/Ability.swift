//
//  Ability.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/15.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import Foundation
struct Ability :Codable{
    struct Name: Codable, LanguageTextEntry {
          let language: Language
          let name: String

          var text: String { name }
      }

      struct FlavorTextEntry: Codable, LanguageTextEntry {
          let language: Language
          let flavorText: String

          var text: String { flavorText }
      }

      let id: Int

      let names: [Name]
      let flavorTextEntries: [FlavorTextEntry]
}
