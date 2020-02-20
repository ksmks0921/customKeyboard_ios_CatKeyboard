//
//  settingVC.swift
//  CustomKeyboard
//
//  Created by Panda Star on 2/18/20.
//  Copyright © 2020 Ethan Sarif-Kattan. All rights reserved.
//

import UIKit

class settingVC: UIViewController {

    @IBOutlet weak var capitalizeSwitch: UISwitch!
    @IBOutlet weak var correctionSwitch: UISwitch!
    @IBOutlet weak var capslockSwitch: UISwitch!
    
    @IBOutlet weak var shortcutSwitch: UISwitch!
    @IBOutlet weak var predictiveSwitch: UISwitch!
    
    
    let defaults = UserDefaults(suiteName: "group.spellex")
    let autocapslock = "autocapslock"
    let correction = "correction"
    let capitalize = "capitalize"
    let shortcut = "shortcut"
    let predictive = "predictive"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        
        setupStorageVariable()
       
    }
    private func setupStorageVariable() {
        
        
        
        let defaultValue_autocapslock = [autocapslock : true]
        let defaultValue_correction = [correction : true]
        let defaultValue_capitalize = [capitalize : true]
        let defaultValue_shortcut = [shortcut : true]
        let defaultValue_predictive = [predictive : true]
        
        defaults?.register(defaults: defaultValue_autocapslock)
        defaults?.register(defaults: defaultValue_correction)
        defaults?.register(defaults: defaultValue_capitalize)
        defaults?.register(defaults: defaultValue_shortcut)
        defaults?.register(defaults: defaultValue_predictive)
        defaults!.synchronize()
        
    }
    private func setupUI(){
        
        capitalizeSwitch.onTintColor = UIColor.white
        
        capitalizeSwitch.backgroundColor = UIColor.white
        capitalizeSwitch.layer.cornerRadius = 16
        capitalizeSwitch.layer.borderColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        capitalizeSwitch.layer.borderWidth = 1.0
        
        if !UserDefaults.standard.bool(forKey: capitalize) {
            capitalizeSwitch.setOn(false, animated: false)
            capitalizeSwitch.thumbTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        else {
            capitalizeSwitch.setOn(true, animated: false)
            capitalizeSwitch.thumbTintColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        }

        
        correctionSwitch.onTintColor = UIColor.white
        correctionSwitch.backgroundColor = UIColor.white
        correctionSwitch.layer.cornerRadius = 16
        correctionSwitch.layer.borderColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        correctionSwitch.layer.borderWidth = 1.0
        
        if !UserDefaults.standard.bool(forKey: correction) {
            correctionSwitch.setOn(false, animated: false)
            correctionSwitch.thumbTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        else {
            correctionSwitch.setOn(true, animated: false)
            correctionSwitch.thumbTintColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        }

        
        capslockSwitch.onTintColor = UIColor.white
        capslockSwitch.backgroundColor = UIColor.white
        capslockSwitch.layer.cornerRadius = 16
        capslockSwitch.layer.borderColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        capslockSwitch.layer.borderWidth = 1.0
        
        if !UserDefaults.standard.bool(forKey: autocapslock) {
            capslockSwitch.setOn(false, animated: false)
            capslockSwitch.thumbTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        else {
            capslockSwitch.setOn(true, animated: false)
            capslockSwitch.thumbTintColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        }
        
        shortcutSwitch.onTintColor = UIColor.white
        shortcutSwitch.backgroundColor = UIColor.white
        shortcutSwitch.layer.cornerRadius = 16
        shortcutSwitch.layer.borderColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        shortcutSwitch.layer.borderWidth = 1.0
        
        if !UserDefaults.standard.bool(forKey: shortcut) {
            shortcutSwitch.setOn(false, animated: false)
            shortcutSwitch.thumbTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        else {
            shortcutSwitch.setOn(true, animated: false)
            shortcutSwitch.thumbTintColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        }
        
        predictiveSwitch.onTintColor = UIColor.white
        predictiveSwitch.backgroundColor = UIColor.white
        predictiveSwitch.layer.cornerRadius = 16
        predictiveSwitch.layer.borderColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        predictiveSwitch.layer.borderWidth = 1.0
        
        if !UserDefaults.standard.bool(forKey: predictive) {
            predictiveSwitch.setOn(false, animated: false)
            predictiveSwitch.thumbTintColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        }
        else {
            predictiveSwitch.setOn(true, animated: false)
            predictiveSwitch.thumbTintColor = #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1)
        }
        
        
        
    }
    
    
    @IBAction func capitalSwitchToglged(_ sender: Any) {
        
        capitalizeSwitch.thumbTintColor = capitalizeSwitch.isOn ? #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        if capitalizeSwitch.isOn {
            defaults?.set(true, forKey: capitalize)
        }
        else {
            defaults?.set(false, forKey: capitalize)
        }
        
    }
    
    @IBAction func correctionSwitchToggled(_ sender: Any) {
        correctionSwitch.thumbTintColor = correctionSwitch.isOn ? #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        if correctionSwitch.isOn {
            defaults?.set(true, forKey: correction)
        }
        else {
            defaults?.set(false, forKey: correction)
        }
        
    }
    @IBAction func capslockSwitchToggled(_ sender: Any) {
        
        capslockSwitch.thumbTintColor = capslockSwitch.isOn ? #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        if capslockSwitch.isOn {
            defaults?.set(true, forKey: autocapslock)
        }
        else {
            defaults?.set(false, forKey: autocapslock)
        }
        
    }
    @IBAction func predictiveSwitchToggled(_ sender: Any) {
        
        predictiveSwitch.thumbTintColor = predictiveSwitch.isOn ? #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        
        if predictiveSwitch.isOn {
            defaults?.set(true, forKey: predictive)
        }
        else {
            defaults?.set(false, forKey: predictive)
        }
    }
    
    @IBAction func shortcutSwitchToggled(_ sender: Any) {
        
        shortcutSwitch.thumbTintColor = shortcutSwitch.isOn ? #colorLiteral(red: 0.2078431373, green: 0.6784313725, blue: 0.7450980392, alpha: 1) : #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        if shortcutSwitch.isOn {
            print("on")
            defaults?.set(true, forKey: shortcut)
        }
        else {
            print("off")
            defaults?.set(false, forKey: shortcut)
        }
        
    }
    
    @IBAction func backBtnTapped(_ sender: Any) {
           
        self.navigationController?.popViewController(animated: true)
           
    }



}
