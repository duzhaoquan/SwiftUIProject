//
//  PokemonInfoRow.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/16.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import SwiftUI
import SafariServices

struct PokemonInfoRow: View {
    
    
    let model : PokemonViewModel
    var expanded :Bool
    @State var isShowingPanel:Bool = false
    
    var body: some View {
        
        VStack{
            HStack{
                Image("Pokemon-\(model.id)")
                    .resizable()
                    .frame(width: CGFloat(50.0), height: CGFloat(50.0), alignment: Alignment.center)
                    .aspectRatio(contentMode: ContentMode.fit)
                    .shadow(radius: CGFloat(4))
                
                Spacer()
                VStack(alignment: .trailing){
                    Text(model.name)
                        .font(.title)
                        .fontWeight(Font.Weight.black)
                        .foregroundColor(.white)
                    Text(model.nameEN)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
            }.padding(.top, 12)
            Spacer()
            HStack(spacing: expanded ? 20 : -30){
                Spacer()
                Button(action: {}) {
                    Image(systemName: "star")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    
                }
                Button(action: {}) {
                    Image(systemName: "chart.bar")
                        .font(.system(size: 25))
                        .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                }
                Button(action: {
                    self.isShowingPanel = true
                }) {
                    Image(systemName: "info.circle")
                    .modifier(ToolButtonModifier())
                }
                .sheet(isPresented: self.$isShowingPanel) {

                    PokemonInfoPanel(model: self.model)
                }
                
//                NavigationLink(destination: SafariView(url: model.detailPageURL, onFinished: {
//                           self.store.dispatch(.closeSafariView)
//                       }), isActive: expanded ? $store.appState.pokemonList.isSFViewActive : .constant(false)) {
//                           Image(systemName: "info.circle").modifier(ToolButtonModifier())
//                }
                
            }.opacity(expanded ? 1.0 : 0.0)
                .frame(maxHeight: expanded ? .infinity : 0)
            
        }.frame(height: expanded ? 120 : 80)
            .padding(.leading, 23)
            .padding(.trailing, 15)
            .background(
                ZStack{
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(model.color, style: StrokeStyle(lineWidth: 4))
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(LinearGradient(gradient: Gradient(colors: [.white,model.color]), startPoint: .leading, endPoint:.trailing))
                            
                }
                
        ).padding(.horizontal)
            .animation(
            .spring(
            response: 0.55,
            dampingFraction: 0.425, blendDuration: 0)
            )
//            .onTapGesture {
//                let animation = Animation
//                .linear(duration: 0.3)
//                .delay(0.1)
//                withAnimation(animation) { self.expanded.toggle()
//                }
//        }
        
    }
}

struct PokemonInfoRow_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            PokemonInfoRow(model: PokemonViewModel.sample(id: 1), expanded: false)
            PokemonInfoRow(model: PokemonViewModel.sample(id: 21), expanded: true)
            PokemonInfoRow(model: PokemonViewModel.sample(id: 25), expanded: false)
        }
        
    }
}

struct ToolButtonModifier:ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 25))
        .foregroundColor(.white)
        .frame(width: 30, height: 30)
    }
    
}


struct SafariView: UIViewControllerRepresentable {
    
    let url: URL
    let onFinished: () -> Void
        
    // View被创建的时候调用
    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
        let controller = SFSafariViewController(url: url)
        controller.delegate = context.coordinator
        return controller
    }
    
    // body刷新的时候调用
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, SFSafariViewControllerDelegate {
        let parent: SafariView
        
        init(_ parent: SafariView) {
            self.parent = parent
        }
            
        func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
            parent.onFinished()
        }
    }
}
