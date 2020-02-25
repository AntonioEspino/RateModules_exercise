//
//  RateModuleViewController.swift
//  RateModule1
//
//  Created by Adrian Tineo on 26.01.20.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import UIKit

class RateModuleViewController: UITableViewController {
    static let showRateModuleSegue = "showRateModule"
    static 
    var state = State(module: Module.module3B)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = Module.module3B.rawValue
    }
    
    private func update(selectedQuestion: Question, with value: Bool) {
        var index = RateModuleViewController.state.designQuestions?.firstIndex { $0.title == selectedQuestion.title }
        if let index = index {
            RateModuleViewController.state.designQuestions![index].isPassed = value
            return
        }
        
        index = RateModuleViewController.state.requirementsQuestions.firstIndex { $0.title == selectedQuestion.title }
        if let index = index {
            RateModuleViewController.state.requirementsQuestions[index].isPassed = value
            return
        }
        
        index = RateModuleViewController.state.codeStructureQuestions.firstIndex { $0.title == selectedQuestion.title }
        if let index = index {
            RateModuleViewController.state.codeStructureQuestions[index].isPassed = value
            return
        }
        
        index = RateModuleViewController.state.cleanCodeQuestions.firstIndex { $0.title == selectedQuestion.title }
        if let index = index {
            RateModuleViewController.state.cleanCodeQuestions[index].isPassed = value
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowRateResults", let destination = segue.destination as? RateResultsViewController {
            destination.rateCalculator = RateCalculator(
                numberOfDesignQuestions: RateModuleViewController.state.hasDesignSection ? RateModuleViewController.state.designQuestions!.count : 0,
                numberOfRightlyAnsweredDesignQuestions: RateModuleViewController.state.hasDesignSection ? RateModuleViewController.state.designQuestions!.filter { $0.isPassed }.count : 0,
                numberOfRequirementQuestions: RateModuleViewController.state.requirementsQuestions.count,
                numberOfRightlyAnsweredRequirementQuestions: RateModuleViewController.state.requirementsQuestions.filter { $0.isPassed }.count,
                numberOfCodeStructureQuestions: RateModuleViewController.state.codeStructureQuestions.count,
                numberOfRightlyAnsweredCodeStructureQuestions: RateModuleViewController.state.codeStructureQuestions.filter { $0.isPassed }.count,
                numberOfCleanCodeQuestions: RateModuleViewController.state.cleanCodeQuestions.count,
                numberOfRightlyAnsweredCleanCodeQuestions: RateModuleViewController.state.cleanCodeQuestions.filter { $0.isPassed }.count)
        }
    }
}

// MARK: data source

extension RateModuleViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return RateModuleViewController.state.hasDesignSection ? 4 : 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return RateModuleViewController.state.hasDesignSection ? RateModuleViewController.state.designQuestions!.count : RateModuleViewController.state.requirementsQuestions.count
        case 1:
            return RateModuleViewController.state.hasDesignSection ? RateModuleViewController.state.requirementsQuestions.count : RateModuleViewController.state.codeStructureQuestions.count
        case 2:
            return RateModuleViewController.state.hasDesignSection ? RateModuleViewController.state.codeStructureQuestions.count : RateModuleViewController.state.cleanCodeQuestions.count
        case 3:
            return RateModuleViewController.state.hasDesignSection ? RateModuleViewController.state.cleanCodeQuestions.count : 0
        default:
            fatalError("Unexpected section")
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.identifier, for: indexPath) as! QuestionTableViewCell
        cell.delegate = self
        let indexPosition: Int
        var maxPosition = 0
        
        
        let question: Question?
        switch section {
        case 0:
            if RateModuleViewController.state.hasDesignSection {
                question = RateModuleViewController.state.designQuestions![indexPath.row]
                maxPosition = RateModuleViewController.state.designQuestions?.count ?? 0
                
            } else {
                question = RateModuleViewController.state.requirementsQuestions[indexPath.row]
                maxPosition = RateModuleViewController.state.requirementsQuestions.count
            }
        case 1:
            if RateModuleViewController.state.hasDesignSection {
                question = RateModuleViewController.state.requirementsQuestions[indexPath.row]
                maxPosition = RateModuleViewController.state.requirementsQuestions.count
            } else {
                question = RateModuleViewController.state.codeStructureQuestions[indexPath.row]
                maxPosition = RateModuleViewController.state.codeStructureQuestions.count
            }
        case 2:
            if RateModuleViewController.state.hasDesignSection {
                question = RateModuleViewController.state.codeStructureQuestions[indexPath.row]
                maxPosition = RateModuleViewController.state.codeStructureQuestions.count
            } else {
                question = RateModuleViewController.state.cleanCodeQuestions[indexPath.row]
                maxPosition = RateModuleViewController.state.cleanCodeQuestions.count
            }
        case 3:
            if RateModuleViewController.state.hasDesignSection {
                question = RateModuleViewController.state.cleanCodeQuestions[indexPath.row]
                maxPosition = RateModuleViewController.state.cleanCodeQuestions.count
            } else {
                question = nil
            }
        default:
            question = nil
        }
        indexPosition = indexPath.row + 1
        
        if let question = question {
            cell.configure(with: question, indexPosition: indexPosition, maxPosition: maxPosition)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
       let header = tableView.dequeueReusableCell(withIdentifier: "RateModuleSectionHeader")!
               switch section {
                   case 0:
                    header.textLabel?.text = RateModuleViewController.state.hasDesignSection ? "Diseño (\(RateModuleViewController.state.designQuestions?.count ?? 0))" : "Requisitos (\(RateModuleViewController.state.requirementsQuestions.count))"
                   case 1:
                    header.textLabel?.text = RateModuleViewController.state.hasDesignSection ? "Requisitos (\(RateModuleViewController.state.requirementsQuestions.count))" : "Estructura de código (\(RateModuleViewController.state.codeStructureQuestions.count))"
                   case 2:
                    header.textLabel?.text = RateModuleViewController.state.hasDesignSection ? "Estructura de código (\(RateModuleViewController.state.codeStructureQuestions.count))": "Código limpio (\(RateModuleViewController.state.cleanCodeQuestions.count))"
                   case 3:
                    header.textLabel?.text = RateModuleViewController.state.hasDesignSection ? "Código limpio (\(RateModuleViewController.state.cleanCodeQuestions.count))" : ""
                   default:
                       fatalError("Unexpected section")
               }
               return header
    }
}

extension RateModuleViewController: QuestionTableViewCellDelegate {
    func didToggleSwitch(for question: Question, value: Bool) {
        update(selectedQuestion: question, with: value)
        tableView.reloadData()
    }
}

