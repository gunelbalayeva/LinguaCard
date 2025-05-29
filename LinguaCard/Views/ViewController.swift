//
//  ViewController.swift
//  LinguaCard
//
//  Created by User on 29.05.25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    let languageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("🌐", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let cardView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowRadius = 8
        view.backgroundColor = .brown
        return view
    }()
    
    let quoteLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Keep moving forward".localized()
        label.font = UIFont(name: "Zapfino", size: 24)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let nextQuoteButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Next Quote", for: .normal)
        button.setTitleColor(UIColor.getRandomColor(), for: .normal)
        return button
    }()
    
    private var selectedLanguage: String = Language.az.rawValue
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
        setupActions()
        
        for family in UIFont.familyNames {
            print("Font family: \(family)")
            for name in UIFont.fontNames(forFamilyName: family) {
                print("   Font name: \(name)")
            }
        }

    }
    
    private func setupSubviews() {
        view.addSubview(cardView)
        cardView.addSubview(quoteLabel)
        view.addSubview(languageButton)
        view.addSubview(nextQuoteButton)
    }
    
    private func setupConstraints() {
        cardView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
            make.height.equalTo(200)
        }
        
        quoteLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
        }
        
        languageButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }
        
        nextQuoteButton.snp.makeConstraints { make in
            make.top.equalTo(cardView.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
    }
    
    private func setupActions() {
        languageButton.addTarget(self, action: #selector(languageButtonTapped), for: .touchUpInside)
        nextQuoteButton.addTarget(self, action: #selector(didTapNextQuote), for: .touchUpInside)
    }
    
    @objc func languageButtonTapped() {
        let alert = UIAlertController(title: "Select Language", message: "\n\n\n\n\n\n", preferredStyle: .alert)
        
        let pickerVC = UIViewController()
        pickerVC.preferredContentSize = CGSize(width: 250, height: 200)
        let picker = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
        picker.delegate = self
        picker.dataSource = self
        pickerVC.view.addSubview(picker)
        
        alert.setValue(pickerVC, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: "OK", style: .default) { _ in
            self.showConfirmationAlert(for: self.selectedLanguage)
            Manager.shared.change(Language(rawValue: self.selectedLanguage)!)
            self.updateTexts()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        
        present(alert, animated: true)
    }
    
    private func showConfirmationAlert(for language: String) {
        let alert = UIAlertController(title: "Language Selected", message: "You selected \(language.localized())", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc
    func didTapNextQuote() {
        cardView.backgroundColor = UIColor.getRandomColor()
        
    }

    private func updateTexts() {
        quoteLabel.text = "text".localized()
        nextQuoteButton.setTitle("author".localized(), for: .normal)
    }
}



extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Language.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return Language.allCases[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedLanguage = Language.allCases[row].rawValue
    }
    
}


extension UIColor {
    static func getRandomColor() -> UIColor {
        let red = CGFloat.random(in: 0.3...1.0)
        let green = CGFloat.random(in: 0.3...1.0)
        let blue = CGFloat.random(in: 0.3...1.0)
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
