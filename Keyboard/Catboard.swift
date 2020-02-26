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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        
        UserDefaults.standard.register(defaults: [kCatTypeEnabled: true])
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    func getPredictive(word : String) -> [String] {
        
        //NSString *prefix = [word substringToIndex:word.length - 1];
        let index = word.index(word.endIndex, offsetBy: -1)
        let prefix = word[..<index]
        
        // Won't get suggestions for correct words, so we are scrambling the words
        //NSString *scrambledWord = [NSString stringWithFormat:@"%@%@",word, [self getRandomCharAsNSString]];
        let randomChar = String.init(format: "%ca", arc4random_uniform(26))
        let scrambledWord = "\(word)\(randomChar)"
        
        //UITextChecker *checker = [[UITextChecker alloc] init];
        let checker = UITextChecker()
        let checkRange = NSMakeRange(0, scrambledWord.count)
        
        //NSRange checkRange = NSMakeRange(0, scrambledWord.length);
//        NSRange misspelledRange = [checker rangeOfMisspelledWordInString:scrambledWord range:checkRange     startingAt:checkRange.location wrap:YES  language:@"en_US"];

        let misspelledRange = checker.rangeOfMisspelledWord(in: scrambledWord, range: checkRange, startingAt: checkRange.location, wrap: true, language: "en_US")
        // NSArray *arrGuessed = [checker guessesForWordRange:misspelledRange inString:scrambledWord language:@"en_US"];
        // NSLog(@"Arr ===== %@",arrGuessed);
        // Filter the result based on the word
        let arrGuessed = checker.guesses(forWordRange: misspelledRange, in: scrambledWord, language: "en_US")! as NSArray
        
        //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@",word];
        let predicate = NSPredicate.init(format: "SELF BEGINSWITH[c] %@", word)
        
        //NSArray *arrayfiltered = [arrGuessed filteredArrayUsingPredicate:predicate];
        var arrayfiltered = arrGuessed.filtered(using: predicate)
        if(arrayfiltered.count == 0)
        {
            // Filter the result based on the prefix
            //NSPredicate *newPredicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@",prefix];
            let newPredicate = NSPredicate.init(format: "SELF BEGINSWITH[c] %@", word)
            //arrayfiltered = [arrGuessed filteredArrayUsingPredicate:newPredicate];
            arrayfiltered = arrGuessed.filtered(using: newPredicate)
        }
        
//        for suggestionItem in arrayfiltered {
//
//
//            catboardBanner?.suggestion_1?.setTitle( (suggestionItem as! String), for: .normal)
//
//        }
        return arrayfiltered as! [String]
        
    }
    override func keyPressed(_ key: Key) {
       
        let textDocumentProxy = self.textDocumentProxy
        let keyOutput = key.outputForCase(self.shiftState.uppercase())
        
        var currentWord: String? {
          var lastWord: String?
          // 1
            if let stringBeforeCursor = textDocumentProxy.documentContextBeforeInput {
            // 2
                stringBeforeCursor.enumerateSubstrings(in: stringBeforeCursor.startIndex...,
                                                       options: .byWords)
            { word, _, _, _ in
              // 3
              if let word = word {
                lastWord = word
              }
            }
          }
            return lastWord
        }
        
        if currentWord != nil {
            
            let textChecker = UITextChecker()
            let randomChar = String.init(format: "%ca", arc4random_uniform(26))
            let scrambledWord = "\(currentWord)\(randomChar)"
            
            let misspelledRange =
                textChecker.rangeOfMisspelledWord(in: scrambledWord,
                                                  range: NSRange(0..<scrambledWord.utf16.count),
                                                  startingAt: 0,
                                                  wrap: false,
                                                  language: "en_US")

            if misspelledRange.location != NSNotFound,
                let firstGuess = textChecker.guesses(forWordRange: misspelledRange,
                                                     in: scrambledWord,
                                                     language: "en_US")?.first
                
            {
                catboardBanner?.suggestion_1?.setTitle(firstGuess, for: .normal)
                print("First guess: \(firstGuess)") // First guess: hipster
            } else {
                
                print("Not found")
            }
            
            
            
            if misspelledRange.location != NSNotFound,
                let secondGuess = textChecker.guesses(forWordRange: misspelledRange,
                                                     in: currentWord!,
                                                     language: "en_US")?[1]

            {
                catboardBanner?.suggestion_2?.setTitle(secondGuess, for: .normal)
                print("First guess: \(secondGuess)") // First guess: hipster
            } else {
                catboardBanner?.suggestion_2?.setTitle("", for: .normal)
                print("Not found")
            }
            
            
            if misspelledRange.location != NSNotFound,
                let thirdGuess = textChecker.guesses(forWordRange: misspelledRange,
                                                     in: currentWord!,
                    language: "en_US")?[1]

            {

                catboardBanner?.suggestion_3?.setTitle(thirdGuess, for: .normal)
                print("First guess: \(thirdGuess)") // First guess: hipster
            } else {
                catboardBanner?.suggestion_3?.setTitle("", for: .normal)
                print("Not found")
            }
        }
        
        
//        var lastWordTyped: String? {
//            if let documentContext = textDocumentProxy.documentContextBeforeInput as NSString? {
//                let length = documentContext.length
//                if length > 0 && (CharacterSet.letters as NSCharacterSet).characterIsMember(documentContext.character(at: length - 1)) {
//                    let components = documentContext.components(separatedBy: CharacterSet(charactersIn:"=\"#%/<>?@\\^`{|}").inverted)
//                    return components[components.endIndex - 1]
//                }
//            }
//            return nil
//        }
//        textDocumentProxy.currentWordPostCursorPart
//        if currentWord == nil {
//            catboardBanner?.suggestion_1?.setTitle(keyOutput, for: .normal)
//        }
//        else {
//            if key.type != .character || key.type != .specialCharacter {
//                if keyOutput != " " {
//                    catboardBanner?.suggestion_1?.setTitle(currentWord! + keyOutput, for: .normal)
//                }
//                else {
//                    catboardBanner?.suggestion_1?.setTitle("", for: .normal)
//                }
//            }
//        }
    
        
        
        
//        if currentWord != nil {
//            catboardBanner?.suggestion_1?.setTitle(getPredictive(word: currentWord!)[1], for: .normal)
//        }
//        else {
//            catboardBanner?.suggestion_1?.setTitle(getPredictive(word: "i")[1], for: .normal)
//        }
        
        
        

       
        
        
        
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
        
        catboardBanner = CatboardBanner(globalColors: type(of: self).globalColors, darkMode: false, solidColorMode: self.solidColorMode())
        catboardBanner!.delegate = self
        
        //TOMSSuggestionBar *suggestionBar = [[TOMSSuggestionBar alloc] init];
      

        return catboardBanner

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

func randomCat() -> String {
    let cats = "🐱😺😸😹😽😻😿😾😼🙀"
    
    let numCats = cats.count
    let randomCat = arc4random() % UInt32(numCats)
    
    let index = cats.index(cats.startIndex, offsetBy: Int(randomCat))
    let character = cats[index]
    
    return String(character)
}

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
    }
}
