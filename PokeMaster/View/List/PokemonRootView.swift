//
//  PokemonRootView.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/17.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import SwiftUI

struct PokemonRootView: View {
    var body: some View {
        NavigationView {
            PokemonList().navigationBarTitle("宝可梦列表")
        }
    }
}

struct PokemonRootView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonRootView()
    }
}
