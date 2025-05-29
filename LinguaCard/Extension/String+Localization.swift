//
//  String+Localization.swift
//  LinguaCard
//
//  Created by User on 29.05.25.
//

import UIKit

extension String {
    func localized() -> String {
        if let path = Bundle.main.path(forResource:Manager.shared.get(), ofType: "lproj"),
           let bundle = Bundle(path: path){
            return NSLocalizedString(self,bundle: bundle ,comment: "")
        }
        return self
    }
}
