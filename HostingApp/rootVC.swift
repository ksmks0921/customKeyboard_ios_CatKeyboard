//
//  ViewController.swift
//
//  Created by Ethan Sarif-Kattan on 09/07/2019.
//  Copyright © 2019 Ethan Sarif-Kattan. All rights reserved.
//

import UIKit

class rootVC: UIViewController {
    
    
	@IBOutlet weak var instructions: UITextView!
	@IBOutlet weak var dismissKeyboardButton: UIButton!
    
    @IBOutlet weak var tutorialBtn: UIButton!
    
    @IBOutlet weak var settingBtn: UIButton!
    let defaults = UserDefaults(suiteName: "group.spellex")
    let words = "words"
    var allWords: [String] = []
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    override func viewDidLoad() {
		super.viewDidLoad()

        let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
        dispatchQueue.async{
            self.addSpellIgnoreData(filename: "data")
            self.defaults?.set(self.allWords, forKey: self.words)
            print(self.allWords.count)

        }
        

        

	}
    
    @IBAction func settingBtnTapped(_ sender: Any) {
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "settingVC") as! settingVC
        navigationController?.pushViewController(VC, animated: true)
    }
    
    @IBAction func tutorialBtnTapped(_ sender: Any) {
        
        print("Hey! Tutorial button is tapped!")
        
        let VC = self.storyboard?.instantiateViewController(withIdentifier: "tutorialVC") as! tutorialVC
        navigationController?.pushViewController(VC, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
         navigationController?.setNavigationBarHidden(true, animated: animated)
		setupUI()
	}
	
	@IBAction func dismissKeyboardPressed(_ sender: Any) {
            instructions.resignFirstResponder()
	}

    
    func addSpellIgnoreData(filename: String){
        print("Start.....")
       
//        if let stringPath = Bundle.main.path(forResource: filename, ofType: "txt")
//               {
//                 do {
//                    let data = try String(contentsOfFile: stringPath, encoding: String.Encoding(rawValue: String.Encoding.ascii.rawValue))
//                        let myStrings = data.components(separatedBy: .newlines)
//                        for word in myStrings {
//                            print(word)
//                            UITextChecker.learnWord(word)
//                        }
//
//                   } catch {
//                       print(error)
//                   }
//
//                }
        
        
        let pathURL = URL(fileURLWithPath: Bundle.main.path(forResource: filename, ofType: "txt")!)
        if FileManager.default.fileExists(atPath: pathURL.path) { print(1) }

        let s = StreamReader(url: pathURL)
        for _ in 1...227654 {
            if let line = s?.nextLine() {
                allWords.append(line)
                print(line)
            }
        }
        
        
        
    }
    
	func setupUI(){
        
        tutorialBtn.layer.cornerRadius = 80
        tutorialBtn.layer.borderWidth = 1
        tutorialBtn.layer.borderColor = UIColor.clear.cgColor
        
        settingBtn.layer.cornerRadius = 80
        settingBtn.layer.borderWidth = 1
        settingBtn.layer.borderColor = UIColor.clear.cgColor
        

        
        
	}



}

