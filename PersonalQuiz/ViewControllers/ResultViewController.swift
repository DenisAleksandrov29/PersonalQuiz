//
//  ResultViewController.swift
//  PersonalQuiz
//
//  Created by Денис Александров on 07.05.2024.
//

import UIKit

final class ResultViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet var resultLabel: UILabel!
    @IBOutlet var whoAreYouLabel: UILabel!
    
    var answersChosen: [Answer] = []
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let (resultText, mostFrequentAnimal) = processAnswers()
        
        resultLabel.text = resultText
        if let mostFrequentAnimal = mostFrequentAnimal {
            whoAreYouLabel.text = " Вы \(mostFrequentAnimal.rawValue) - \(mostFrequentAnimal.definition)"
        } else {
            whoAreYouLabel.text = "Нет данных"
        }
        
        hidingData()
    }
    
    // MARK: - IB Action
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true)
    }
    
    // MARK: - Private Methods
    private func processAnswers() -> (String, Animal?) {
        let animalDescriptions = answersChosen.map { "\($0.animal.rawValue) - \($0.animal.definition)" }
        let animalCounts = Dictionary(grouping: answersChosen.map { $0.animal }, by: { $0 }).mapValues { $0.count }
        
        let resultText = animalDescriptions.joined(separator: "\n")
        let mostFrequentAnimal = animalCounts.max(by: { $0.value < $1.value })?.key
        
        return (resultText, mostFrequentAnimal)
    }
    
    private func hidingData() {
        navigationItem.leftBarButtonItem = nil
        navigationItem.hidesBackButton = true
    }
    
    deinit {
        print("\(type(of: self)) has been deallocated")
    }
}





