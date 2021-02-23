//
//  PokemonList.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/17.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import SwiftUI

struct PokemonList: View {
    
    
    @State var SearchString: String = ""
    @EnvironmentObject var store: Store
    var body: some View {
        
        ScrollView{
            TextField("筛选", text: $SearchString)
            
            ForEach(PokemonViewModel.all) { pokeman in
                PokemonInfoRow(model: pokeman, expanded: self.store.appState.pokemonList.expandingIndex == pokeman.id)
                .onTapGesture {
                    
                    if self.store.appState.pokemonList.expandingIndex == pokeman.id {
                        self.store.dispath(AppAction.toggleListSelection(index: nil))
                    }else{
                        self.store.dispath(AppAction.toggleListSelection(index: pokeman.id))
                    }
                }
    
            }
       
        }
//        .overlay(
//            VStack{
//                Spacer()
//                PokemonInfoPanel(model: PokemonViewModel.sample(id: 1))
//            }.edgesIgnoringSafeArea(.bottom)
//        )
        
//hihihi
        
    }
}

struct PokemonList_Previews: PreviewProvider {
    static var previews: some View {
        PokemonList()
    }
}
