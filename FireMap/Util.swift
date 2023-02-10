//
//  Util.swift
//  FireMap
//
//  Created by KimWooJin on 2023/02/10.
//

import Foundation

class Util {
    static func error_print(title: String, _ file: String, _ function: String, _ line: Int) {
        print("===== \(title) =====")
        print("File Name: \(file)")
        print("Function Name: \(function)")
        print("line: \(line)")
    }
}
