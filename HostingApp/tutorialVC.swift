//
//  tutorialVC.swift
//  CustomKeyboard
//
//  Created by Panda Star on 2/18/20.
//  Copyright © 2020 Ethan Sarif-Kattan. All rights reserved.
//

import UIKit

class tutorialVC: UIViewController {
    
    @IBOutlet weak var addbtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()

        
    }
 
    
    func setupUI(){
       addbtn.layer.cornerRadius = 7
       addbtn.layer.borderWidth = 1
       addbtn.layer.borderColor = UIColor.clear.cgColor
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func addBtnTapped(_ sender: Any) {
        
    }
    

}
