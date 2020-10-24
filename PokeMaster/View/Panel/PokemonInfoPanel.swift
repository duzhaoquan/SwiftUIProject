//
//  PokemonInfoPanel.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/17.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import SwiftUI

struct PokemonInfoPanel: View {
    let model : PokemonViewModel
    
    var abilities:[AbilityViewModel]{
        AbilityViewModel.sample(pokemonID: model.id)
    }
    
    var topIndicator :some View{
        RoundedRectangle(cornerRadius: 3)
        .frame(width: 40, height: 6)
            .opacity(0.2)
    }
    
    var pokemonDescription :some View{
        Text("\(model.descriptionText)")
            .font(.system(size: 10))
        .foregroundColor(Color(hex: 0x666666))
        .fixedSize(horizontal: false, vertical: true)
        
    }
    
    var body: some View {
        
        VStack(spacing:20){
          
            topIndicator
            Header(model: model)
            pokemonDescription
            Divider()
            AbilityList(model: model, abilityModels: abilities)
            
        }.padding(EdgeInsets(top: 10, leading: 30, bottom: 30, trailing: 30))
//            .background(Color.white)
            .blurBackground(style: .systemMaterial)
            .cornerRadius(20)
            .fixedSize(horizontal: false, vertical: true)
            
    }
}

extension PokemonInfoPanel{
    struct Header:View {
        
        let model : PokemonViewModel
        
        var body: some View {
            HStack(spacing:18){
                pokemonIcon
                nameSpecies
                verticalDivider
                VStack(spacing:12){
                    bodyStatus
                    typeInfo
                }
            }
        
        }
        var pokemonIcon :some View {
            Image("Pokemon-\(model.id)")
            .resizable()
            .frame(width: 68, height: 68)
            
        }
        var nameSpecies :some View{
            VStack{
                Text("\(model.name)")
                    .font(.system(size: 22))
                    .foregroundColor(model.color)
                    .bold()
                
                Text("\(model.nameEN)")
                    .font(.system(size: 13))
                    .foregroundColor(model.color)
                    .bold()
                Text("\(model.genus)")
                    .font(.system(size: 13))
                    .foregroundColor(.gray)
                    .padding(.top, 10)
                
            }
            
        }
        var verticalDivider :some View{
            Rectangle()
            .frame(width: 1, height: 44)
                .background(Color("#000000@0.1"))
                .opacity(0.2)
        }
        
        var bodyStatus :some View {
            VStack(alignment:.leading){
                HStack(){
                    Text("身高")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text("\(model.height)")
                        .font(.system(size: 11))
                        .foregroundColor(model.color)

                }
                HStack{
                    Text("体重")
                        .font(.system(size: 11))
                        .foregroundColor(.gray)
                    Text("\(model.weight)")
                        .font(.system(size: 11))
                        .foregroundColor(model.color)

                }
            }
        }
        
        var typeInfo :some View{
            HStack(spacing:10){
                ForEach(model.types){ type in
                    Text("\(type.name)")
                        .frame(width: 36, height: 14)
                        .font(.system(size: 10))
                        .background(type.color)
                        .foregroundColor(.white)
                        .cornerRadius(7)
                        
                    
                }
            }
            
            
        }
    }
}
extension PokemonInfoPanel {
    
    struct AbilityList: View {
        
        let model: PokemonViewModel
        let abilityModels: [AbilityViewModel]?
        
        var body: some View {
            
            VStack(alignment: .leading, spacing: 12) {
                
                Text("技能")
                    .font(.headline)
                    .fontWeight(.bold)
                
                if abilityModels != nil {
                    
                    ForEach(abilityModels!) { ability in
                        
                        Text(ability.name)
                            .font(.subheadline)
                            .foregroundColor(self.model.color)
                        Text(ability.descriptionText)
                            .font(.footnote)
                            .foregroundColor(Color(hex: 0xAAAAAA))
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}
struct PokemonInfoPanel_Previews: PreviewProvider {
    static var previews: some View {
        PokemonInfoPanel(model: PokemonViewModel.sample(id: 1))
    }
}
