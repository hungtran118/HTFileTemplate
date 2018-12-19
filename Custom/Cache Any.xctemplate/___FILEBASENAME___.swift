//___FILEHEADER___

import Foundation

class ___FILEBASENAMEASIDENTIFIER___<T>: NSCache<NSString, AnyObject> {
    
    subscript(key: String) -> T? {
        get {
            return object(forKey: key as NSString) as? T
        }
        set {
            if let newValue = newValue {
                setObject(newValue as AnyObject, forKey: key as NSString)
            }
            else {
                removeObject(forKey: key as NSString)
            }
        }
    }
}

/*
 _____.*'USAGE'*._____
 
 - Init: CacheAny<'Type'>()
    + ex: let cacheAny = CacheAny<CGFloat>()
 
 - Store: cacheAny["key"] = value
 
 - Get Value: cacheAny["key"] ?? default value
 
 - Remove all value: cacheAny.removeAllObjects()
 
 - Remove for key: cacheAny.removeObject(forKey: "key") or cacheAny["key"] = nil
 
 */
