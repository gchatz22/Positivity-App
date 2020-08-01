//
//  IntroView.swift
//  Positivity
//
//  Created by Giannis Chatziveroglou on 7/4/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct IntroView: View {
    
    @State var firstName : String = "Giannis"
    @State var lastName : String = "Chatziveroglou"
    
    
    var body: some View {
        ZStack{
            
            Color("BkgColor")
            
            VStack{
                
                Spacer()
                
                HStackText(field: "What's your name?")
                
                
                TextField("", text: $firstName)
                    .multilineTextAlignment(.center)
                    .padding()
                    .frame(maxWidth: 350, alignment: .center)
                    .background(Color("DarkBkgColor"))
                    
                
                
                Button(action: {
                    Backend.shared.enterMainView()
                }){
                    Text("Redirect me!")
                }
                
                Spacer()
                
            }
        
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct HStackText: View {
    
    var field: String
    
    var body: some View {
        HStack{
            Spacer()
            Text(field)
                .font(.largeTitle)
                .padding(.top, 20)

            Spacer()
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView().previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}
