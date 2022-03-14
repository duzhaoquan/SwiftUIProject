//
//  SwiftUIView.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/17.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//2012 j

import SwiftUI

struct SettingRootView: View {
    var body: some View {
        NavigationView {
            SettingView().navigationBarTitle("设置")
        }
    }
}
//hello swiftUI
struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SettingRootView()
    }
}
