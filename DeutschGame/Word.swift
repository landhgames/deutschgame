//
//  Word.swift
//  DeutschGame
//
//  Created by Nacho on 2/11/16.
//  Copyright © 2016 LandhGames™. All rights reserved.
//

import UIKit

class Word: NSObject {
    var englishVersion : String
    var germanVersion : String
    var spanishVersion : String
    var score = 0
    var rating = 0 // Rating means #times used
    
    var englishToGerman = true
    
    override init(){        
        self.englishVersion = ""
        self.germanVersion = ""
        self.spanishVersion = ""
        super.init()
    }
    
    convenience init(english : String, german : String, spanish : String){        
        self.init()
        self.englishVersion = english
        self.germanVersion = german
        self.spanishVersion = spanish
        
    }
    
    func addCorrectGuess(){
        self.score++
    }
    
    func addWrongGuess(){
        self.score--
    }
    
    func getOriginWord() -> String{
        if(self.englishToGerman)
        {
            return self.englishVersion
        }
        else
        {
            return self.germanVersion
        }
    }
    
    func getDestinWord() -> String{
        if(self.englishToGerman)
        {
            return self.germanVersion
        }
        else
        {
            return self.englishVersion
        }

    }
    
    func addRating(){
        self.rating++
    }
}
