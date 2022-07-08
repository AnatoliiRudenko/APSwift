//
//  String.swift
//  Trade Union
//
//  Created by Анатолий Руденко on 08.12.2021.
//

import Foundation

public extension String {
    
    func tail(afterCount count: Int) -> String {
        String(suffix(from: self.index(startIndex, offsetBy: count)))
    }
    
    func sliced(from: String, to: String) -> String? {
        (range(of: from)?.upperBound).flatMap { substringFrom in
            (range(of: to, range: substringFrom..<endIndex)?.lowerBound).map { substringTo in
                String(self[substringFrom..<substringTo])
            }
        }
    }
    
//    func applyPattern(_ pattern: String, replacementLetterCharacter: Character?, replacementNumberCharacter: Character?) -> String {
//        var value = self.replacingOccurrences(of: ".*[^A-Za-z0-9 ].*", with: "", options: .regularExpression)
//        replaceCharacters(in: &value, pattern: pattern, replacementCharacter: replacementLetterCharacter)
//        replaceCharacters(in: &value, pattern: pattern, replacementCharacter: replacementNumberCharacter)
//        return value
//    }
    
    func applyPatternOnNumbers(_ pattern: String, replacementCharacter: Character) -> String {
        var pureNumber = self.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        replaceCharacters(in: &pureNumber, pattern: pattern, replacementCharacter: replacementCharacter)
        return pureNumber
    }
    
    var filteredPhoneNumber: String {
        let okayChars = Set("+0123456789")
        return self.filter { okayChars.contains($0) }
    }
    
    var phoneNumberFormat: String {
        let pattern = "+# (###) ### ## ##"
        return self.applyPatternOnNumbers(pattern, replacementCharacter: "#")
    }
    
    // MARK: - Validity checks
    var isValidEmail: Bool {
        let emailRegEx = "^[\\w\\.-]+@([\\w\\-]+\\.)+[A-Z]{1,4}$"
        let emailTest = NSPredicate(format: "SELF MATCHES[c] %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    var isValidPhoneNumber: Bool {
        filteredPhoneNumber.starts(with: "+7") && filteredPhoneNumber.count == 12
    }
    
    // MARK: - Content checks
    
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
    
    var isDigital: Bool {
        CharacterSet.decimalDigits.isSuperset(of: CharacterSet(charactersIn: self))
    }
}

// MARK: - Attributes
public extension String {
    
    func addAttributes(_ attributes: [NSAttributedString.Key: Any], to string: String?) -> NSMutableAttributedString? {
        guard let string = string, !string.isEmpty,
              let rangeOfString = self.range(of: string),
              let nsRange = self.nsRange(from: rangeOfString)
        else { return nil }
        let attrString = NSMutableAttributedString(string: self)
        attrString.addAttributes(attributes, range: nsRange)
        return attrString
    }
    
    func nsRange(from range: Range<String.Index>) -> NSRange? {
        guard let from = range.lowerBound.samePosition(in: utf16),
              let to = range.upperBound.samePosition(in: utf16)
        else { return nil }
        return NSRange(location: utf16.distance(from: utf16.startIndex, to: from),
                       length: utf16.distance(from: from, to: to))
    }
}

// MARK: - HTML String
public extension String {
    
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

// MARK: - Static
public extension String {
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }
}

// MARK: - Supporting methods
private extension String {
    
    func replaceCharacters(in value: inout String, pattern: String, replacementCharacter: Character?) {
        guard let replacementCharacter = replacementCharacter else { return }
        for index in 0 ..< pattern.count {
            guard index < value.count else { return }
            let stringIndex = String.Index(utf16Offset: index, in: pattern)
            let patternCharacter = pattern[stringIndex]
            guard patternCharacter != replacementCharacter else { continue }
            value.insert(patternCharacter, at: stringIndex)
        }
    }
}
