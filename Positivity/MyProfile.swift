//
//  Profile.swift
//  Positivity
//
//  Created by Giannis Chatziveroglou on 6/28/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import SwiftUI

struct MyProfile: View {
    
    @State var name = Backend.shared.getName()
    @State var imgPaths = Backend.shared.getFilePaths()
    var columns: Int = 3
//    let imagesDir = Bundle.main.resourcePath!+"/Charms/"
    
    
    var body: some View {
        ZStack{
            
            Color("BkgColor")
            
            VStack{
                
                Text(self.name!+"'s charms")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .padding(.top, 50)

                
                CharmsFeed(imgPaths: imgPaths)
                
                
            }
            
            
        }
        .edgesIgnoringSafeArea(.top)
    }
}


struct CharmsFeed: View{
    
    var imgPaths: [[String]]
    
    var body: some View {
        
        ScrollView{
            
            ForEach(imgPaths, id: \.self) { row in
                
                HStack{
                    ForEach(row, id: \.self) { path in
                        Image("charms/"+path)
                        .resizable()
                        .scaledToFit()
                        .padding()
                            .shadow(radius: 5, y: 20)
                    }
                }
            }
            
        }
        .frame(maxWidth: 400)
            
        
    }
    
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        MyProfile().previewDevice(PreviewDevice(rawValue: "iPhone XS Max"))
    }
}
