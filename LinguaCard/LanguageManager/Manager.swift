//
//  Manager.swift
//  LinguaCard
//
//  Created by User on 29.05.25.
//

import UIKit

enum Language: String, CaseIterable {
    case az
    case en
    case ru
    case tr
    
    var title: String {
        switch self {
        case .az: return "Azərbaycan dili"
        case .en: return "English"
        case .ru: return "Русский"
        case .tr : return "Türkçe"
        }
    }
}

class Manager {
    static let shared = Manager()
    private let applicationLanguageKey = "selectedlanguage"
    var currentLanguage:String = Language.az.rawValue
    
    func change(_ language :Language){
        UserDefaults.standard.setValue(language.rawValue, forKey: applicationLanguageKey)
    }
    
    func get() -> String {
        if let currentLanguage = UserDefaults.standard.value(forKey: applicationLanguageKey) as? String {
            return currentLanguage
        }
        return Language.az.rawValue
    }
}
