//
//  CatboardBanner.swift
//  TastyImitationKeyboard
//
//  Created by Alexei Baboulevitch on 10/5/14.
//  Copyright (c) 2014 Alexei Baboulevitch ("Archagon"). All rights reserved.
//

import UIKit

/*
This is the demo banner. The banner is needed so that the top row popups have somewhere to go. Might as well fill it
with something (or leave it blank if you like.)
*/

protocol listenKeyClick {
    func listenToSuggestion(_ key: String)
}

class CatboardBanner: ExtraView {
    
    var catSwitch: UISwitch = UISwitch()
    var catLabel: UILabel = UILabel()
    var suggestion_1, suggestion_2, suggestion_3: UIButton?
    var delegate: listenSuggestionClick?
    
    required init(globalColors: GlobalColors.Type?, darkMode: Bool, solidColorMode: Bool) {
        super.init(globalColors: globalColors, darkMode: darkMode, solidColorMode: solidColorMode)
        
//        self.addSubview(self.catSwitch)
//        self.addSubview(self.catLabel)
   
        
//        self.catSwitch.isOn = UserDefaults.standard.bool(forKey: kCatTypeEnabled)
//        self.catSwitch.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
//        self.catSwitch.addTarget(self, action: #selector(CatboardBanner.respondToSwitch), for: UIControl.Event.valueChanged)
        
        
        
        
        self.updateAppearance()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

    
        suggestion_1 = UIButton(frame: CGRect(x: 0, y: 0, width: self.layer.frame.width / 3, height: self.layer.frame.height))
        suggestion_1!.center = CGPoint(x: self.layer.frame.width / 6, y: self.layer.frame.height / 2)
        suggestion_1!.setTitle("suggestion_1", for: .normal)
        suggestion_1?.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(suggestion_1!)
        
        
        suggestion_2 = UIButton(frame: CGRect(x: self.layer.frame.width / 3, y: 0, width: self.layer.frame.width / 3, height: self.layer.frame.height))
        suggestion_2!.setTitle("suggestion_2", for: .normal)
        suggestion_2?.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(suggestion_2!)
        
     
        suggestion_3 = UIButton(frame: CGRect(x: self.layer.frame.width / 3 * 2, y: 0, width: self.layer.frame.width / 3, height: self.layer.frame.height))

        suggestion_3!.setTitle("suggestion_3", for: .normal)
        suggestion_3?.setTitleColor(UIColor.black, for: .normal)
        self.addSubview(suggestion_3!)
        

        suggestion_2?.addTarget(self, action: #selector(CatboardBanner.addSuggestionSecond), for: .touchDown)
        suggestion_1?.addTarget(self, action: #selector(CatboardBanner.addSuggestionFirst), for: .touchDown)
        suggestion_3?.addTarget(self, action: #selector(CatboardBanner.addSuggestionThird), for: .touchDown)
        
//        self.catSwitch.center = self.center
//        self.catLabel.center = self.center
//
//        self.catLabel.frame.origin = CGPoint(x: self.catSwitch.frame.origin.x + self.catSwitch.frame.width + 8, y: self.catLabel.frame.origin.y)
//        self.catLabel.text = "suggestion_1"
        
    }

    @objc func addSuggestionSecond() {

        delegate?.listenTo((self.suggestion_2?.title(for: .normal))!)
    }
    @objc func addSuggestionFirst() {

        delegate?.listenTo((self.suggestion_1?.title(for: .normal))!)
    }
    @objc func addSuggestionThird() {

        delegate?.listenTo((self.suggestion_3?.title(for: .normal))!)
    }
    
    
    @objc func respondToSwitch() {
     
        UserDefaults.standard.set(self.catSwitch.isOn, forKey: kCatTypeEnabled)
        self.updateAppearance()
        
        
    }
    
    func updateAppearance() {
        
        if self.catSwitch.isOn {
            self.catLabel.text = "😺"
            self.catLabel.alpha = 1
        }
        else {
            self.catLabel.text = "🐱"
            self.catLabel.alpha = 0.5
        }

        self.catLabel.sizeToFit()
    }
    
    
}

extension CatboardBanner: listenKeyClick {
    
    func listenToSuggestion(_ key: String) {
        self.suggestion_1?.setTitle(key, for: .normal)
    }
    
   
}
