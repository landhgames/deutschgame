//
//  ViewController.swift
//  DeutschGame
//
//  Created by Nacho on 2/6/16.
//  Copyright © 2016 LandhGames™. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController , GetCVSProtocol{

    @IBOutlet weak var lblWord: UILabel!
    @IBOutlet weak var userEnteredTxt: UITextField!
    @IBOutlet weak var lblScore: UILabel!
    
    var theDictionary = Dictionary<String,Word>()
    var randomWord : (String,Word)!
    var score : Int = 100
    
    var audioPlayerSuccess = AVAudioPlayer()
    var audioPlayerError = AVAudioPlayer()
    
    var myUtterance = AVSpeechUtterance(string: "")
    var englishToGerman : Bool = true
    
    var gameBrain = GameBrain(englishToGerman:false)
    
    override func viewDidLoad() {
        gameBrain = GameBrain(englishToGerman: self.englishToGerman)
        super.viewDidLoad()        
        let word = self.gameBrain.getNewWord()
        lblWord.text = word.1.getDestinWord()
        randomWord = word
        
        self.initSound()
    }
    
    func initSound(){
        let successSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("success", ofType: "mp3")!)
        let errorSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("error", ofType: "mp3")!)

        do {
            audioPlayerSuccess = try AVAudioPlayer(contentsOfURL: successSound)
        } catch {
            print("No sound found by URL:\(successSound)")
        }
        
        do {
            audioPlayerError = try AVAudioPlayer(contentsOfURL: errorSound)
        } catch {
            print("No sound found by URL:\(errorSound)")
        }
        audioPlayerSuccess.prepareToPlay()
        audioPlayerError.prepareToPlay()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    @IBAction func didFinishWritting(sender: AnyObject) {
        
        let originWord = randomWord.1.getOriginWord().lowercaseString
        if(userEnteredTxt.text?.lowercaseString == originWord)
        {
            self.score += 10            
            audioPlayerSuccess.play()
            //self.gameBrain.didWriteWordOk(Language.English, str: self.randomWord.1.getOriginWord())
            self.updateRandomWord()
        }
        else
        {
            //self.gameBrain.didWriteWordWrong(Language.English, str: self.randomWord.1.getOriginWord())
            // Mal, ERROR!!
            audioPlayerError.play()
            self.score -= 10
            self.lblWord.text = randomWord.1.getDestinWord()
            self.lblWord.textColor = UIColor.redColor()
            let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.updateRandomWord()
            self.lblWord.textColor = UIColor.blackColor()
            }
        }
        
        
    }
    
    @IBAction func didPressTellMe(sender: UIButton) {
        self.lblWord.text = randomWord.1.getOriginWord()
        self.lblWord.textColor = UIColor.redColor()
        
        if(randomWord.1.germanVersion.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0){
            self.speakWord(randomWord.1.getOriginWord())
        }
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
            dispatch_after(delayTime, dispatch_get_main_queue()) {
            //self.updateRandomWord()
            self.lblWord.textColor = UIColor.blackColor()
        }
        
    }
    
    func updateRandomWord(){
        self.randomWord = self.gameBrain.getNewWord()
        self.lblWord.text = self.randomWord.1.getDestinWord()
        self.lblScore.text = "\(self.score) pts."
        self.userEnteredTxt.text = ""
        self.gameBrain.printWordScores()
    }
    

    
    func getRandomWord() -> (String,Word){
        let pos = Int(arc4random_uniform(UInt32(theDictionary.count)) + 1)
        var arr = Array(Zip2Sequence(theDictionary.keys, theDictionary.values))
        let rv : (String,Word) = arr[pos-1]
        
        return rv
        
    }
    
    func didReceiveNewWordDictionary(newDicc : Dictionary<String,Word>){
        self.theDictionary = newDicc
    }
    
    func speakWord(utterance : String){
        //let string = "Hallo wie gehts heute? alles gut?"
        
        let utterance = AVSpeechUtterance(string:utterance)
        
        if(self.englishToGerman)
        {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        }
        else
        {
            utterance.voice = AVSpeechSynthesisVoice(language: "de-DE")
        }
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speakUtterance(utterance)
    }
    
}

