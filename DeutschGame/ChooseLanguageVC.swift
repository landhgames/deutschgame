//
//  ChooseLanguageVCViewController.swift
//  DeutschGame
//
//  Created by Nacho on 2/11/16.
//  Copyright © 2016 LandhGames™. All rights reserved.
//

import UIKit

class ChooseLanguageVC: UIViewController {

    var selectedEnglishToDeutsh : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftAddBarButtonItem:UIBarButtonItem = UIBarButtonItem(title: "End Game >", style: UIBarButtonItemStyle.Plain, target: self, action: "endGame:")
        self.navigationItem.setLeftBarButtonItems([leftAddBarButtonItem], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didPressDeutschEnglish(sender: UIButton){
        selectedEnglishToDeutsh = false
    }
    @IBAction func didPressEnglishDeutsch(sender: UIButton){
        selectedEnglishToDeutsh = true
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?){
        let addSpend = segue.destinationViewController as! ViewController
        //let addSpend = nav.topViewController as! ViewController
        
        addSpend.englishToGerman = selectedEnglishToDeutsh
        
        
    }
    
    
    func endGame(button : UIButton){
        
    }
    

}
