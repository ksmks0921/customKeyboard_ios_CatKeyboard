//
//  KeyboardViewController+Autocomplete.swift
//  KeyboardKitDemoKeyboard
//
//  Created by Daniel Saidi on 2019-10-15.
//  Copyright © 2018 Daniel Saidi. All rights reserved.
//

import KeyboardKit
import UIKit

extension KeyboardViewController {
    
    func requestAutocompleteSuggestions() {
        
        let word = textDocumentProxy.currentWord ?? ""
           autocompleteProvider.autocompleteSuggestions(for: word) { [weak self] in
               self?.handleAutocompleteSuggestionsResult($0)
            
           }
       
        
    }
//    func alert(_ message: String) {
//        guard let input = inputViewController as? KeyboardViewController else { return }
//        input.alerter.alert(message: message, in: input.view, withDuration: 4)
//    }
    
    func resetAutocompleteSuggestions() {
        autocompleteToolbar.reset()
    }
    
}

private extension KeyboardViewController {
    
    func handleAutocompleteSuggestionsResult(_ result: AutocompleteResult) {
        switch result {
        case .failure(let error): print(error.localizedDescription)
        case .success(let result): autocompleteToolbar.update(with: result)
        }
    }
}
