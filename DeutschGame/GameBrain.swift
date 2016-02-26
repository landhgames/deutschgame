//
//  GameBrain.swift
//  DeutschGame
//
//  Created by Nacho on 2/11/16.
//  Copyright © 2016 LandhGames™. All rights reserved.
//

import UIKit

protocol GameBrainProtocol{
    func didGetNewWord()->Word
}

enum Language {
    case English
    case German
    case Spanish
}

enum GameState{
    case getGoodScoreWord
    case getNoScoreWord
    case getBadScoreWord
}

class currentLanguage{
    func getCurrentDestinationLanguage()->Language{
        return Language.German
    }
    
    func getCurrentOriginLanguage()->Language{
        return Language.English
    }

}

class GameBrain: NSObject,GetCVSProtocol {
    var theDictionary =         Dictionary<String,Word>()
    var state : GameState = GameState.getNoScoreWord
    var englishToGerman : Bool = true
    
     init(englishToGerman : Bool){
        super.init()
        let csv = GetCSV()
        self.initDictionary()
        csv.delegate = self
        csv.download()
        self.englishToGerman = englishToGerman
    }    
    
    func initDictionary(){
        let w = Word(english: "hello", german: "hallo", spanish: "hola")
        theDictionary.updateValue(w, forKey: "hello")
    }
    
    func didWriteWordOk(language : Language, str : String){
        if let word = self.theDictionary[str]{
            word.addCorrectGuess()
            word.addRating()
            self.theDictionary.updateValue(word, forKey: str)
            self.checkWordCorrectess(word)
            
        }
    }
    
    func didWriteWordWrong(language : Language, str : String){
        if let word = self.theDictionary[str] {
            word.addWrongGuess()
            word.addRating()
            self.theDictionary.updateValue(word, forKey: word.englishVersion)
            self.checkWordCorrectess(word)
        }
    }
    
    func checkWordCorrectess(word : Word){
//        if((word.score > 5) && theDictionary[word.englishVersion] != nil)
//        {
//           wordUserDoesntKnow[word.englishVersion] = nil
//           wordsUserKnow[word.englishVersion] = word
//        }
//        
//        if((word.score <= 0) && wordsUserKnow[word.englishVersion] != nil)
//        {
//            wordUserDoesntKnow[word.englishVersion] = word
//            wordsUserKnow[word.englishVersion] = nil
//        }
    }
    
    func getNewWord() -> (String,Word){
        let pos = Int(arc4random_uniform(UInt32(theDictionary.count)) + 1)
        var arr = Array(Zip2Sequence(theDictionary.keys, theDictionary.values))
        let rv : (String,Word) = arr[pos-1]
        rv.1.englishToGerman = self.englishToGerman
        return rv
        
    }
    
    // <------------ Delegate ------------>
    
    func didReceiveNewWordDictionary(newDicc : Dictionary<String,Word>){
        self.consolidateDictionary(newDicc)
    }
    
    func consolidateDictionary(dict : Dictionary<String,Word>){
        print("~ Dictionary consolidated ~")
        for k in dict.keys {
            self.theDictionary.updateValue(dict[k]!, forKey: k)
        }
    }
    
    func printWordScores(){
        for k in theDictionary.keys{
            let w : Word = theDictionary[k]!
            print("\(w.englishVersion): \(w.score) \n")
        }
    }
}
