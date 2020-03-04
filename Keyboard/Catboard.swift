//
//  Catboard.swift
//  TransliteratingKeyboard
//
//  Created by Alexei Baboulevitch on 9/24/14.
//  Copyright (c) 2014 Alexei Baboulevitch ("Archagon"). All rights reserved.
//

import UIKit

/*
This is the demo keyboard. If you're implementing your own keyboard, simply follow the example here and then
set the name of your KeyboardViewController subclass in the Info.plist file.
*/

let kCatTypeEnabled = "kCatTypeEnabled"

protocol listenSuggestionClick {
    func listenTo(_ suggestion: String)
 
}


class Catboard: KeyboardViewController {
    
    let takeDebugScreenshot: Bool = false
    
    var catboardBanner: CatboardBanner?
    let allWords = defaultsToKeyboard?.array(forKey: words)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        UserDefaults.standard.register(defaults: [kCatTypeEnabled: true])
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }

    override func keyPressed(_ key: Key) {
       
        let textDocumentProxy = self.textDocumentProxy
        let keyOutput = key.outputForCase(self.shiftState.uppercase())
        
        
        if currentWord != nil {

            
//            let textChecker = UITextChecker()
//            let randomChar = String.init(format: "%ca", arc4random_uniform(26))
//            let scrambledWord = "\(currentWord!)\(randomChar)"
            
//            let misspelledRange =
//                textChecker.rangeOfMisspelledWord(in: scrambledWord,
//                                                            range: NSRange(0..<scrambledWord.utf16.count),
//                                                            startingAt: 0,
//                                                            wrap: false,
//                                                            language: "en_US")
            let predicate = NSPredicate(format: "SELF contains %@", currentWord!)
            
            
            let arrayfiltered = allWords!.filter { predicate.evaluate(with: $0) }
          
            
                if arrayfiltered.count >= 3 {
                    catboardBanner?.suggestion_1?.setTitle(arrayfiltered.first as! String, for: .normal)
                    catboardBanner?.suggestion_2?.setTitle(arrayfiltered[1] as! String, for: .normal)
                    catboardBanner?.suggestion_3?.setTitle(arrayfiltered[2] as! String, for: .normal)
                }
                else if arrayfiltered.count == 2 {
                    catboardBanner?.suggestion_1?.setTitle(arrayfiltered.first as! String, for: .normal)
                    catboardBanner?.suggestion_2?.setTitle(arrayfiltered[1] as! String, for: .normal)
                    catboardBanner?.suggestion_3?.setTitle(arrayfiltered.first as! String, for: .normal)
                }
                else if arrayfiltered.count == 1 {
                    catboardBanner?.suggestion_1?.setTitle(arrayfiltered.first as! String, for: .normal)
                    catboardBanner?.suggestion_2?.setTitle(arrayfiltered.first as! String, for: .normal)
                    catboardBanner?.suggestion_3?.setTitle((arrayfiltered.first as! String), for: .normal)
                }
//            if misspelledRange.location != NSNotFound,
//                let Guess = textChecker.guesses(forWordRange: misspelledRange,
//                                                in: scrambledWord,
//                                            language: "en_US"){
//                if Guess.count >= 3 {
//                    catboardBanner?.suggestion_1?.setTitle(Guess.first, for: .normal)
//                    catboardBanner?.suggestion_2?.setTitle(Guess[1], for: .normal)
//                    catboardBanner?.suggestion_3?.setTitle(Guess[2], for: .normal)
//                }
//                else if Guess.count == 2 {
//                    catboardBanner?.suggestion_1?.setTitle(Guess.first, for: .normal)
//                    catboardBanner?.suggestion_2?.setTitle(Guess[1], for: .normal)
//                    catboardBanner?.suggestion_3?.setTitle(Guess.first, for: .normal)
//                }
//                else if Guess.count == 1 {
//                    catboardBanner?.suggestion_1?.setTitle(Guess.first, for: .normal)
//                    catboardBanner?.suggestion_2?.setTitle(Guess.first, for: .normal)
//                    catboardBanner?.suggestion_3?.setTitle(Guess.first, for: .normal)
//                }
//
//
//            }
//            else {
//                catboardBanner?.suggestion_1?.setTitle("", for: .normal)
//                catboardBanner?.suggestion_2?.setTitle("", for: .normal)
//                catboardBanner?.suggestion_3?.setTitle("", for: .normal)
//            }
            

            
//            if arrayfiltered.count == 0 {
//
//                        let newPredicate = NSPredicate.init(format: "SELF contains[c] %@", currentWord!)
//
//                        var arrayfiltered = Guess!.filter { newPredicate.evaluate(with: $0) }
//
//                        catboardBanner?.suggestion_1?.setTitle("0", for: .normal)
//
//            }
//            else {
//                catboardBanner?.suggestion_1?.setTitle(String(arrayfiltered.count), for: .normal)
//
//
//
//            }
            
            
            

        }
        
        else {
            
           
            let randomChar = String.init(format: "%ca", arc4random_uniform(26))
            let scrambledWord = "\(keyOutput)\(randomChar)"
            let textChecker = UITextChecker()
            let misspelledRange =
                                  textChecker.rangeOfMisspelledWord(in: scrambledWord,
                                                                    range: NSRange(0..<scrambledWord.utf16.count),
                                                                    startingAt: 0,
                                                                    wrap: false,
                                                                    language: "en_US")
            
            if misspelledRange.location != NSNotFound,
                let Guess = textChecker.guesses(forWordRange: misspelledRange,
                                               in: scrambledWord,
                                            language: "en_US"){
                if Guess.count >= 3 {
                    catboardBanner?.suggestion_1?.setTitle(Guess.first, for: .normal)
                    catboardBanner?.suggestion_2?.setTitle(Guess[1], for: .normal)
                    catboardBanner?.suggestion_3?.setTitle(Guess[2], for: .normal)
                }
                else if Guess.count == 2 {
                    catboardBanner?.suggestion_1?.setTitle(Guess.first, for: .normal)
                    catboardBanner?.suggestion_2?.setTitle(Guess[1], for: .normal)
                    catboardBanner?.suggestion_3?.setTitle(Guess.first, for: .normal)
                }
                else if Guess.count == 1 {
                    catboardBanner?.suggestion_1?.setTitle(Guess.first, for: .normal)
                    catboardBanner?.suggestion_2?.setTitle(Guess.first, for: .normal)
                    catboardBanner?.suggestion_3?.setTitle(Guess.first, for: .normal)
                }


            }
            else {
                catboardBanner?.suggestion_1?.setTitle("", for: .normal)
                catboardBanner?.suggestion_2?.setTitle("", for: .normal)
                catboardBanner?.suggestion_3?.setTitle("", for: .normal)
            }
            
        }
        
        

        

       
        
        
        
        if !UserDefaults.standard.bool(forKey: kCatTypeEnabled) {
            textDocumentProxy.insertText(keyOutput)
            return
        }
        
        if key.type == .character || key.type == .specialCharacter {
            if let context = textDocumentProxy.documentContextBeforeInput {
                if context.count < 2 {
                    textDocumentProxy.insertText(keyOutput)
                    return
                }
                
                var index = context.endIndex
                
                index = context.index(before: index)
                if context[index] != " " {
                    textDocumentProxy.insertText(keyOutput)
                    return
                }
                
                index = context.index(before: index)
                if context[index] == " " {
                    textDocumentProxy.insertText(keyOutput)
                    return
                }

//                textDocumentProxy.insertText("\(randomCat())")
                textDocumentProxy.insertText(" ")
                textDocumentProxy.insertText(keyOutput)
                return
            }
            else {
                textDocumentProxy.insertText(keyOutput)
                return
            }
        }
        else {
            textDocumentProxy.insertText(keyOutput)
            return
        }
    }
    
    override func setupKeys() {
        super.setupKeys()
        
        if takeDebugScreenshot {
            if self.layout == nil {
                return
            }
            
            for page in keyboard.pages {
                for rowKeys in page.rows {
                    for key in rowKeys {
                        if let keyView = self.layout!.viewForKey(key) {
                            keyView.addTarget(self, action: #selector(Catboard.takeScreenshotDelay), for: .touchDown)
                        }
                    }
                }
            }
                    
        }
    }
    
    override func createBanner() -> ExtraView? {
        
        if (defaultsToKeyboard?.bool(forKey: defaultValue_predictive))!{
           catboardBanner = CatboardBanner(globalColors: type(of: self).globalColors, darkMode: false, solidColorMode: self.solidColorMode())
                  catboardBanner!.delegate = self
                  
                  //TOMSSuggestionBar *suggestionBar = [[TOMSSuggestionBar alloc] init];
                

                  return catboardBanner
        }
        else {
            return nil
        }

    }

    
    @objc func takeScreenshotDelay() {
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(Catboard.takeScreenshot), userInfo: nil, repeats: false)
    }
    
    @objc func takeScreenshot() {
        if !self.view.bounds.isEmpty {
            UIDevice.current.beginGeneratingDeviceOrientationNotifications()
            
            let oldViewColor = self.view.backgroundColor
            self.view.backgroundColor = UIColor(hue: (216/360.0), saturation: 0.05, brightness: 0.86, alpha: 1)
            
            let rect = self.view.bounds
            UIGraphicsBeginImageContextWithOptions(rect.size, true, 0)
            self.view.drawHierarchy(in: self.view.bounds, afterScreenUpdates: true)
            let capturedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            // AB: consider re-enabling this when interfaceOrientation actually breaks
            //// HACK: Detecting orientation manually
            //let screenSize: CGSize = UIScreen.main.bounds.size
            //let orientation: UIInterfaceOrientation = screenSize.width < screenSize.height ? .portrait : .landscapeLeft
            //let name = (orientation.isPortrait ? "Screenshot-Portrait" : "Screenshot-Landscape")
            
            let name = (self.interfaceOrientation.isPortrait ? "Screenshot-Portrait" : "Screenshot-Landscape")
            let imagePath = "/Users/archagon/Documents/Programming/OSX/RussianPhoneticKeyboard/External/tasty-imitation-keyboard/\(name).png"
            
            if let pngRep = capturedImage!.pngData() {
                try? pngRep.write(to: URL(fileURLWithPath: imagePath), options: [.atomic])
            }
            
            self.view.backgroundColor = oldViewColor
        }
    }
}
//
//func randomCat() -> String {
//    let cats = "🐱😺😸😹😽😻😿😾😼🙀"
//
//    let numCats = cats.count
//    let randomCat = arc4random() % UInt32(numCats)
//
//    let index = cats.index(cats.startIndex, offsetBy: Int(randomCat))
//    let character = cats[index]
//
//    return String(character)
//}

extension Catboard: listenSuggestionClick {
    
   
    
    func listenTo(_ suggestion: String) {
        
        guard let entries = userLexicon?.entries,
           let currentWord = currentWord?.lowercased() else {
             return
         }

        
         for _ in 0..<currentWord.count {
           textDocumentProxy.deleteBackward()
         }
         self.textDocumentProxy.insertText(suggestion)
         self.catboardBanner?.suggestion_1?.setTitle("", for: .normal)
         self.catboardBanner?.suggestion_2?.setTitle("", for: .normal)
         self.catboardBanner?.suggestion_3?.setTitle("", for: .normal)
    }
}
