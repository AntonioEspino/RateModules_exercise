//
//  note.swift
//  RateModules
//
//  Created by user164220 on 25/02/2020.
//  Copyright © 2020 adriantineo. All rights reserved.
//

import Foundation


struct Result {
    var name: String
    var module: String
    var emoji: String
    var rate: String
    
    init (){
        self.name = ""
        self.module = ""
        self.emoji = ""
        self.rate = ""
    }
}

extension Result: Codable {
    
    static let archiveURL =
        FileManager.default.urls(for: .documentDirectory,
                                 in: .userDomainMask).first!.appendingPathComponent("Documents")
            .appendingPathExtension("plist")
    
    static func saveToFile(results: [Result]) {
        let propertyListEncoder = PropertyListEncoder()
        let encodedRates = try? propertyListEncoder.encode(results)
        
        try? encodedRates?.write(to: Result.archiveURL, options: .noFileProtection)
        
    }
    
    static func loadFromFile() -> [Result] {
        let propertyListDecoder = PropertyListDecoder()
        
        var finalRatesList: [Result] = []
        
        if let retrievedRates = try? Data(contentsOf: Result.archiveURL),
            let decodedRates = try? propertyListDecoder.decode(Array<Result>.self, from: retrievedRates){
            
            finalRatesList.append(contentsOf: decodedRates.shuffled())
            
            return finalRatesList
        }
        return finalRatesList
    }
    
}
