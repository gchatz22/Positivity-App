//
//  DeedForm.swift
//  Positivity
//
//  Created by Giannis Chatziveroglou on 8/1/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct DeedForm: View {
    
    @Binding var isPresented: Bool
    @State var action: String = ""
    @State var date: String = ""
    @ObservedObject var backend = Backend.shared
    
    var body: some View {
        VStack{
            HStack{
                Spacer()
                Button(action: {
                    let params = ["action": self.action,
                                  "date": self.date]
                    
                    if (self.backend.submitDeed(params: params)){
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4){
                            self.backend.show += (1-self.backend.startingPercentage)/CGFloat(self.backend.randCharmSteps)
                            self.backend.didsMade += 1
                        }
                        self.isPresented.toggle()
                    } else {
                        print("Complete all the fields")
                    }
                    
                }){
                    Text("Submit")
                }
            .padding()
            }
            Spacer()
            
            Field(value: $action, placeholder: "What is your good deed?")
            
            Field(value: $date, placeholder: "When did you do it?")
            
            Spacer()
            
            Text("Slide down to dismiss")
                .foregroundColor(.gray)
            .padding()
        }
    }
}

struct Field: View{
    
    @Binding var value: String
    var placeholder: String = ""
    
    var body: some View{
        
        VStack{
            Text(placeholder)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField(" ", text: $value)
                .frame(height: 35)
                .font(.system(size: 25))
                .multilineTextAlignment(.center)
            
            Divider()
                .frame(height: self.value.count == 0 ? 1 : 2)
                .background(self.value.count == 0 ? Color.gray : Color.blue)
        }
        .padding(.top, 20)
        .padding([.bottom, .horizontal])
    }
}

struct DeedForm_Previews: PreviewProvider {
    
    static var previews: some View {
        DeedForm(isPresented: .constant(true)).previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}
