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
    var backgroundTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier.invalid
    override func viewDidLoad() {
		super.viewDidLoad()
          
//       registerBackgroundTask()
//       doSomething()
        let dispatchQueue = DispatchQueue(label: "QueueIdentification", qos: .background)
       dispatchQueue.async{
        self.addSpellIgnoreData(filename: "data_a")
        self.addSpellIgnoreData(filename: "data_b")
        self.addSpellIgnoreData(filename: "data_c")
        self.addSpellIgnoreData(filename: "data_d")
        self.addSpellIgnoreData(filename: "data_e")
        self.addSpellIgnoreData(filename: "data_f")
        self.addSpellIgnoreData(filename: "data_g")
        self.addSpellIgnoreData(filename: "data_h")
        
        
        
        
//            self.registerBackgroundTask()
//            self.doSomething()

       }
//        
        

        

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
//
//    func doSomething() {
//
//            switch UIApplication.shared.applicationState {
//            case .active:
//              print("App is active.")
////                        addSpellIgnoreData()
//            case .background:
////                      addSpellIgnoreData()
//              print("App is in background.")
//              print("Background time remaining = \(UIApplication.shared.backgroundTimeRemaining) seconds")
//            case .inactive:
//              break
//
//                }
//    }
//
//    func registerBackgroundTask() {
//        backgroundTask = UIApplication.shared.beginBackgroundTask (withName: "Add Task") { [weak self] in
//            self?.endBackgroundTask()
//
//        }
//        assert(backgroundTask != UIBackgroundTaskIdentifier.invalid)
//    }
//
//    func endBackgroundTask() {
//        print("Background task ended.")
//        UIApplication.shared.endBackgroundTask(backgroundTask)
//        backgroundTask = UIBackgroundTaskIdentifier.invalid
//    }
    
    func addSpellIgnoreData(filename: String){
        print("Start.....")
       
        if let stringPath = Bundle.main.path(forResource: filename, ofType: "txt")
               {
                 do {
                    let data = try String(contentsOfFile: stringPath, encoding: String.Encoding(rawValue: String.Encoding.ascii.rawValue))
                        let myStrings = data.components(separatedBy: .newlines)
                        for word in myStrings {
                            print(word)
                            UITextChecker.learnWord(word)
                        }
                       
                   } catch {
                       print(error)
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

