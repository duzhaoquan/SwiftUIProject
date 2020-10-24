//
//  FileStorage.swift
//  PokeMaster
//
//  Created by duzhaoquan on 2020/3/24.
//  Copyright © 2020 duzhaoquan. All rights reserved.
//

import Foundation

@propertyWrapper
struct FileStorage<T:Codable> {
    
    var value: T?
    let fileName : String
    let directory: FileManager.SearchPathDirectory
    
    init(fileName:String,directory:FileManager.SearchPathDirectory) {
        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
        self.fileName = fileName
        self.directory = directory
    }

    var wrappedValue : T?{
        set {
            value = newValue
            if let value = newValue {
                try? FileHelper.writeJSON(value,
                                          to: directory,
                                          fileName: fileName)
                
            } else {
                try? FileHelper.delete(from: directory, fileName: fileName)
            }
        }
        get {
            value
        }
    }
}
