//
//  FormDataHelper.swift
//  NetworkManager
//
//  Created by Parel Creative on 31/03/19.
//  Copyright © 2019 Bibin Jacob Pulickal. All rights reserved.
//

import Foundation

struct FormDataFile {
    var data: Data
    var mimeType: String
    var fileName: String
}

struct FormDataGenerator {
    
    var boundary = UUID().uuidString
    
    func generateBody(parameters: [String: Any]?    = nil,
                      formDataFiles: [FormDataFile] = []) -> Data {
        
        var body                = Data()
        let lineBreak           = "\r\n"
        let boundaryPrefix      = "--\(boundary + lineBreak)"
        let contentDisposition  = "Content-Disposition: form-data;"
        
        parameters?.forEach { (key, value) in
            body += boundaryPrefix
            body += "\(contentDisposition) name=\"\(key)\"\(lineBreak + lineBreak)"
            body += "\(value)\(lineBreak)"
        }
        
        formDataFiles.forEach { formDataFile in
            body += boundaryPrefix
            body += "\(contentDisposition) name=\"file\"; filename=\"\(formDataFile.fileName)\"\(lineBreak)"
            body += "Content-Type: \(formDataFile.mimeType + lineBreak + lineBreak)"
            body += formDataFile.data
            body += lineBreak
        }
        body += "--".appending(boundary.appending("--\(lineBreak)"))
        
        return body
    }
}
