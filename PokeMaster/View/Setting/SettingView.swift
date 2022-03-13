//
//  SettingView.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/17.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import SwiftUI


struct SettingView: View {
    
    var body: some View {
        Form{
            accountSection
            optionSection
            actionSection
        }.alert(item: settingsBinding.loginError) { error in
            Alert(title: Text(error.localizedDescription))
        }
        
    }
    @EnvironmentObject var store: Store
    var settingsBinding: Binding<AppState.Settings> {
        $store.appState.settings
    }
    var settings: AppState.Settings {
        store.appState.settings
    }
    var accountSection :some View {
        //nihao jio
        
        Section(header: Text("账户名")){
            if settings.loginUser == nil{
                Picker(selection: settingsBinding.accountBehavior,label: Text("")) {

                    ForEach(AppState.Settings.AccountBehavior.allCases, id: \.self) {
                        Text($0.text)

                    }


                }.pickerStyle(SegmentedPickerStyle())
                
                TextField("电子邮箱", text: settingsBinding.email)
                SecureField("密码", text: settingsBinding.password)

                if settings.accountBehavior == AppState.Settings.AccountBehavior.register {
                    SecureField("确认密码", text: settingsBinding.verifyPassword)
                }
                if settings.loginRequesting {
                    Text("正在登录。。。")
                }else{
                    Button(settings.accountBehavior.text) {
                        print("登录/注册")
                         self.store.dispath(AppAction.login(email: self.settings.email, password: self.settings.password))

                    }
                }
                
            }else{
                Text(settings.loginUser!.email)
                Button("注销") {
                   print("注销")

                }
            }
            

            
            
            
        }
    }
    var optionSection: some View {
        Section(header: Text("选项")) {
            Toggle(isOn: settingsBinding.showEnglishName) { Text("显示英文名")
            }
            Picker(
                selection: settingsBinding.sorting, label: Text("排序方式"))
                {
                ForEach(AppState.Settings.Sorting.allCases, id: \.self) {
                
                    Text($0.text)
                    
                }
            }
            Toggle(isOn: settingsBinding.showFavoriteOnly) {
                Text("只显示收藏")
            }
       }
    }
    var actionSection:some View{
        Section{
            Button("清空缓存"){
                self.store.dispath(.cleanCache)
            }
        }
    }
    
}

struct SettingView_Previews: PreviewProvider {
    static var previews: some View {
        let store = Store()
        store.appState.settings.sorting = .color
        
        return SettingView().environmentObject(store)
    }
}
