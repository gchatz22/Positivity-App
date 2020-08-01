//
//  Backend.swift
//  Positivity
//
//  Created by Giannis Chatziveroglou on 6/28/20.
//  Copyright © 2020 Giannis Chatziveroglou. All rights reserved.
//

import Foundation
import SwiftUI


class Backend: ObservableObject {
    
    private static let delegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    public static let shared: Backend = Backend()
    public let startingPercentage: CGFloat = 0.2
    @Published public var randCharmPath: String = ""
    @Published public var randCharmSteps: Int = 0
    @Published public var didsMade: Int = 0
    @Published var show: CGFloat = 0.2
    
    func enterMainView(){
        Backend.delegate?.redirect(view: AnyView(ContentView()))
    }
    
    func logDisconnect(){
        let arr: [String] = [self.randCharmPath, String(self.randCharmSteps), String(self.didsMade)]
        print("logged progress")
        UserDefaults.standard.set(arr, forKey: "progress")
    }
    
    func getProgress() -> Bool{
        if let data = UserDefaults.standard.array(forKey: "progress"){
            let arr = (data as? [String])!
            self.randCharmPath = arr[0]
            self.randCharmSteps = Int(arr[1])!
            self.didsMade = Int(arr[2])!
            self.show += ((1-self.startingPercentage)/CGFloat(self.randCharmSteps))*CGFloat(self.didsMade)
            
            print("Progress fetched")
            return true
        } else {
            print("No progress")
            return false
        }
    }
    
    func submitDeed(params: [String: String]) -> Bool{
        
        if (params["action"]!.isEmpty || params["date"]!.isEmpty){
            return false
        }
        
        return true
    }
    
    func getRandomCharm(){
        let samplePath = Int.random(in: 1..<8)
        let sampleSteps = Int.random(in: 7..<15)
        
//        let dict = (data as? [String])!
        self.randCharmPath = "img"+String(samplePath)
        self.randCharmSteps = sampleSteps
        print("random charm is", self.randCharmPath, "with", self.randCharmSteps, "steps")
    }
    
    
    
    func getName() -> String?{
        if let data = UserDefaults.standard.string(forKey: "name"){
            return data
        } else {
            print("Name is nil")
            return nil
        }
    }
    
    func setName(name: String){
        UserDefaults.standard.set(name, forKey: "name")
        print("Set name")
    }
    
    func getFilePaths() -> [[String]]{
        let fm = FileManager.default
        let path = Bundle.main.resourcePath!
        let arr = try! fm.contentsOfDirectory(atPath: path+"/Charms")
        let columns = 3
        
        var tmp: [String] = []
        var img_paths: [[String]] = []
        var counter = 0
        
        for el in arr{
            
            if counter == columns{
                counter = 0
                img_paths.append(tmp)
                tmp = []
            }
            
            tmp.append(el.components(separatedBy: ".")[0])
            counter += 1
        }
        
        if tmp.count != 0{
            for _ in 0..<columns-tmp.count{
                tmp.append("empty")
            }
            img_paths.append(tmp)
        }
        
        print(img_paths)
        return img_paths
        
    }
}
