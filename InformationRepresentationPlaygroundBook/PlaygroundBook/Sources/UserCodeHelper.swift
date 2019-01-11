//
//  UserCodeHelper.swift
//  Book_Sources
//
//  Created by WILLIAM CHAPMAN on 12/19/18.
//

import Foundation
import PlaygroundSupport

public struct UserCodeHelper {
    
    var allText = PlaygroundPage.current.text

    mutating public func setUserCode(newCode: String) {
        self.allText = newCode
    }
    
    public func findUserVarLet() -> [String] {
         let firstUserCodeSection = findUserCodeInputs().first
        if var inputs = firstUserCodeSection?.components(separatedBy: "\n") {
            // var inputs: [String] = []
            inputs = inputs.filter {
                $0.hasPrefix("var ") || $0.hasPrefix("let ")
            }
            return inputs
        }
        return [""]
    }

    //  This function searches for all the sections of code
    //  denoted as "editable code" and puts the entire contents of each
    //  editable code section into elements of an array
    
    public func findUserCodeInputs() -> [String] {
        var inputs: [String] = []
        let scanner = Scanner(string: allText)
        
        while scanner.scanUpTo("//#-editable-code", into: nil) {
            var userInput: NSString? = ""
            scanner.scanUpTo("\n", into: nil)
            scanner.scanUpTo("//#-end-editable-code", into: &userInput)
            
            if userInput != nil {
                inputs.append(String(userInput!))
            }
        }
        
        return inputs
    }

    //  This function searches for all the sections of code
    //  denoted as "editable code" and puts the entire contents of each
    //  editable code section into elements of an array
    
    public func linesInUserCode() -> [String] {
        return allText.components(separatedBy: "\n")
    }
    
    //public func findUserCodeInputs(from input: String) -> [String] {
    //    var inputs: [String] = []
    //    let scanner = Scanner(string: input)
    //
    //    while scanner.scanUpTo("//#-editable-code", into: nil) {
    //        var userInput: NSString? = ""
    //        scanner.scanUpTo("\n", into: nil)
    //        scanner.scanUpTo("//#-end-editable-code", into: &userInput)
    //
    //        if userInput != nil {
    //            inputs.append(String(userInput!))
    //        }
    //    }
    //
    //    return inputs
    //}
    
}

