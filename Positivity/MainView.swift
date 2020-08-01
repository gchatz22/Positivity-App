//
//  Main.swift
//  Positivity
//
//  Created by Giannis Chatziveroglou on 6/28/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var backend = Backend.shared
    @State var isPresented: Bool = false
    
    var body: some View {
        ZStack{
            Color("BkgColor")
            
            VStack{
                
                Button(action: {
                    self.isPresented.toggle()
                }){
                    Text("Add good deed!")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                }
                .sheet(isPresented: $isPresented, content: {
                    DeedForm(isPresented: self.$isPresented)
                })
                .padding(.top, 50)
                .disabled(abs(1-self.backend.show)<0.001)
                
                Spacer()
                
                Image("charms/"+backend.randCharmPath)
                .resizable()
                .shadow(radius: 10)
                .clipped()
                    .frame(maxWidth: self.backend.show*400, maxHeight: self.backend.show*400)
                    .blur(radius: (1-self.backend.show)*30)
                .animation(.spring())
                
                Spacer()
                
                Text(String(self.backend.didsMade)+"/"+String(self.backend.randCharmSteps))
                    .font(.title)
                    .fontWeight(.bold)
                    .frame(maxWidth: 400)
                    .padding(.bottom, 50)
                
                Button(action: {
                    self.backend.show = self.backend.startingPercentage
                    self.backend.didsMade = 0
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                        Backend.shared.getRandomCharm()
                    }
                }){
                    Text("New Charm")
                }.padding()
                
//                Button(action: {
//                    self.backend.getProgress()
//                }){
//                    Text("Disconnect")
//                }.padding()
                
            }
        }
        .edgesIgnoringSafeArea(.top)
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        MainView().previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}
