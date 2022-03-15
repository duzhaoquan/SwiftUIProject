//
//  MainTab.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/17.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//liu yang he

import SwiftUI

struct MainTab: View {
    var body: some View {
        TabView {
            
            PokemonRootView().tabItem {
                Image(systemName: "list.bullet.below.rectangle")
                Text("首页")
            }
            
            SettingRootView().tabItem {
                Image(systemName: "gear")
                Text("设置")
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct MainTab_Previews: PreviewProvider {
    static var previews: some View {
        MainTab()
    }
}
