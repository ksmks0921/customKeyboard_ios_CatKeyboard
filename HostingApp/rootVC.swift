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
    @IBOutlet weak var TutorialText: UILabel!
    
    @IBOutlet weak var settingBtn: UIButton!
    let defaults = UserDefaults(suiteName: "group.spellex")
    let words = "words"
    var allWords: [String] = []
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    override func viewDidLoad() {
		super.viewDidLoad()
        
//        tutorialBtn.isEnabled = false
//        settingBtn.isEnabled = false
        let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
        dispatchQueue.async{
            self.addSpellIgnoreData(filename: "data_b")
            
            
            
            
            self.defaults?.set(self.allWords, forKey: self.words)
            print(self.allWords.count)
           
        }
        
//        let dispatchQueue_1 = DispatchQueue(label: "QueueIdentification_1", qos: .background)
//        dispatchQueue_1.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 2")
//        }
//        let dispatchQueue_2 = DispatchQueue(label: "QueueIdentification_2", qos: .background)
//        dispatchQueue_2.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 3")
//        }
//        let dispatchQueue_3 = DispatchQueue(label: "QueueIdentification_3", qos: .background)
//        dispatchQueue_3.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 4")
//        }
//        let dispatchQueue_4 = DispatchQueue(label: "QueueIdentification_4", qos: .background)
//        dispatchQueue_4.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 5")
//        }
//        let dispatchQueue_5 = DispatchQueue(label: "QueueIdentification_5", qos: .background)
//        dispatchQueue_5.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 6")
//        }
//        let dispatchQueue_6 = DispatchQueue(label: "QueueIdentification_6", qos: .background)
//        dispatchQueue_6.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 7")
//        }
//        let dispatchQueue_7 = DispatchQueue(label: "QueueIdentification_7", qos: .background)
//        dispatchQueue_7.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 8")
//        }
//        let dispatchQueue_8 = DispatchQueue(label: "QueueIdentification_8", qos: .background)
//        dispatchQueue_8.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 9")
//        }
//        let dispatchQueue_9 = DispatchQueue(label: "QueueIdentification_9", qos: .background)
//        dispatchQueue_9.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 10")
//        }
//        let dispatchQueue_10 = DispatchQueue(label: "QueueIdentification_10", qos: .background)
//        dispatchQueue_10.async{
//                   self.addSpellIgnoreData(filename: "data_1 copy 11")
//        }
//        for n in 2...21 {
//            let dispatchQueue_2 = DispatchQueue(label: "QueueIdentification_" + String(n), qos: .background)
//                   dispatchQueue_2.async{
//                              self.addSpellIgnoreData(filename: "data_1 copy " + String(n))
//                   }
//        }

        

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
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
//        self.TutorialText.text = String(hour) + ":" + String(minutes)
  
        print(String(hour) + ":" + String(minutes))
        print("Start.....")
       

//        let pathURL = URL(fileURLWithPath: Bundle.main.path(forResource: filename, ofType: "txt")!)
//        if FileManager.default.fileExists(atPath: pathURL.path) { print(1) }
//
//        let s = StreamReader(url: pathURL)
//        for _ in 1...227654 {
//            if let line = s?.nextLine() {
//                UITextChecker.learnWord(line)
////                allWords.append(line)
//                print(line)
//            }
//        }
        
        if let path = Bundle.main.path(forResource: "data", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                
                   for i in 1...227654 {
                          print(i)
                          UITextChecker.learnWord("line" + String(i))
//                          if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let word = jsonResult[String(i)] as? String {
//                                    UITextChecker.learnWord(word)
//                                    print(word)
//
//                                    // do stuff
//                          }
                }
                
                
                  
              } catch {
                   // handle error
              }
        }
        
        let date_end = Date()
        let calendar_end = Calendar.current
        let hour_end = calendar_end.component(.hour, from: date_end)
        let minutes_end = calendar.component(.minute, from: date_end)
        print("_______Hey! Ended!__________")
        print(String(hour_end) + ":" + String(minutes_end))
//        self.tutorialBtn.isEnabled = true
//        self.settingBtn.isEnabled = true
        self.tutorialBtn.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        self.settingBtn.backgroundColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
//TutorialText
        
        
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

