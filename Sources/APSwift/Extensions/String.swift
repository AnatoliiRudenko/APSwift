//
//  String.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import Foundation

extension String {
    
    var isDigital: Bool {
        CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
    
    func applyPatternOnNumbers(pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        for index in 0 ..< pattern.count {
            guard index < pureNumber.count else { return pureNumber }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            pureNumber.insert(patternCharacter, at: stringIndex)
        }
        return pureNumber
    }
    
    var filteredPhoneNumber: String {
        let okayChars = Set("+0123456789")
        return self.filter { okayChars.contains($0) }
    }
    
    var containsLetters: Bool {
        rangeOfCharacter(from: NSCharacterSet.letters as CharacterSet) != nil
    }
    
    var containsOnlyLetters: Bool {
        rangeOfCharacter(from: NSCharacterSet.letters.inverted) == nil
    }
    
    var containsOnlyNumbers: Bool {
        let set = CharacterSet(charactersIn: "1234567890 ").inverted
        return self.rangeOfCharacter(from: set) == nil
    }
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }
}

// MARK: - HTML String
extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        htmlToAttributedString?.string ?? ""
    }
    
    
    var strippingHTMLTags: String {
        replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil);
    }
}
