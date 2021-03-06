//
//  RateResultsViewController.swift
//  RateModule1
//
//  Created by Adrian Tineo on 26.01.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class RateResultsViewController: UIViewController {
    
    var rateCalculator: RateCalculator?
    var studentName: String?
    var optionChosed: Module?
    var result =  Result ()
    
    @IBOutlet weak var resultEmojiLabel: UILabel!
    @IBOutlet weak var rateAsPercentLabel: UILabel!
    @IBOutlet weak var designRatioLabel: UILabel!
    @IBOutlet weak var requirementsRatioLabel: UILabel!
    @IBOutlet weak var codeStructureRatioLabel: UILabel!
    @IBOutlet weak var cleanCodeRatioLabel: UILabel!
    @IBOutlet weak var showStudentName: UILabel!
    @IBOutlet weak var showModule: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let rateCalculator = rateCalculator else { return }
        
        if rateCalculator.hasPassed {
            resultEmojiLabel.text = "🥳"
        } else {
            resultEmojiLabel.text = "😔"
        }
        showStudentName.text = studentName
        showModule.text = optionChosed?.rawValue
        navigationItem.hidesBackButton = true
        rateAsPercentLabel.text = NSString.init(format: "%.2f", rateCalculator.rateAsPercent) as String + " %"
        if !rateCalculator.hasPassed {
            rateAsPercentLabel.textColor = .red
        }
        
        if rateCalculator.numberOfDesignQuestions > 0 {
            designRatioLabel.text = "Preguntas de diseño: \(rateCalculator.numberOfRightlyAnsweredDesignQuestions)/\(rateCalculator.numberOfDesignQuestions)"
        } else {
            designRatioLabel.isHidden = true
        }
        
        requirementsRatioLabel.text = "Preguntas de requisitos: \(rateCalculator.numberOfRightlyAnsweredRequirementQuestions)/\(rateCalculator.numberOfRequirementQuestions)"
        codeStructureRatioLabel.text = "Preguntas de estructura de código: \(rateCalculator.numberOfRightlyAnsweredCodeStructureQuestions)/\(rateCalculator.numberOfCodeStructureQuestions)"
        cleanCodeRatioLabel.text = "Preguntas de código limpio: \(rateCalculator.numberOfRightlyAnsweredCleanCodeQuestions)/\(rateCalculator.numberOfCleanCodeQuestions)"
        
        
        result.name = studentName ?? ""
        result.module = optionChosed?.rawValue ?? ""
        result.emoji = resultEmojiLabel.text!
        result.rate = String(rateCalculator.totalRatio*100)
        
        if ResultsViewController.results == nil {
            ResultsViewController.results = []
            ResultsViewController.results?.append(result)
        } else {
            ResultsViewController.results?.append(result)
        }
        
        saveStudent(noteStudent: result)
    }
    
    func saveStudent(noteStudent: Result) {
        var listStudents: [Result] = Result.loadFromFile()
        listStudents.append(noteStudent)
        Result.saveToFile(results: listStudents)
    }
    
}
