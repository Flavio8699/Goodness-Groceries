import Foundation

public func NSLocalizedString(_ key: String, lang: String) -> String {
    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)
    
    var translation = NSLocalizedString(key, tableName: nil, bundle: bundle!, value: "", comment: "")
    
    if translation == key {
        let fallbackLanguage = "en"
        let fallbackPath = Bundle.main.path(forResource: fallbackLanguage, ofType: "lproj")
        let fallbackBundle = Bundle(path: fallbackPath!)
        
        translation = NSLocalizedString(key, tableName: nil, bundle: fallbackBundle!, value: "", comment: "")
    }
    
    return translation
}
