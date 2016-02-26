//
//  GetCSV.swift
//  DeutschGame
//
//  Created by Nacho on 2/7/16.
//  Copyright © 2016 LandhGames™. All rights reserved.
//

import UIKit

protocol GetCVSProtocol{
    func didReceiveNewWordDictionary(newDicc : Dictionary<String,Word>)
}

class GetCSV: NSObject {
    
    var delegate : GetCVSProtocol!
    
    var elDictionario = Dictionary<String,Word>()
    
    func download(){
        var rv = [String:Word]()
        let url = NSURL(string: "https://docs.google.com/spreadsheets/d/1ldz79XkwI3YUnFR27JFdLwF-EXO0Rbp5Pr0xf5Nt5NU/pub?gid=0&single=true&output=csv")
        var dataString = ""
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
            //I want to replace this line below with something to save it to a string.
            dataString = String(NSString(data: data!, encoding: NSUTF8StringEncoding))
            //dispatch_async(dispatch_get_main_queue()) {
            let stringArray =  dataString.componentsSeparatedByString("\r\n")
            
            for var line : String in stringArray{
                let definition = self.parseLine(line)
                let word = Word(english: definition.1, german: definition.0, spanish: "")
                rv.updateValue(word, forKey:  definition.1.lowercaseString)
                
            }
            
            self.elDictionario = rv
            self.didReceiveNewWordDictionary()
            
        }
        task.resume()
    }
    
    func parseLine(line : String) -> (String,String){
        var rv : (String,String)
        var stringArr : Array =  line.componentsSeparatedByString(",")
        rv.0 = stringArr[0]
        rv.1 = stringArr[1]
        return rv
    }
    
    func didReceiveNewWordDictionary(){
        self.delegate.didReceiveNewWordDictionary(elDictionario)
    }
    
}






 