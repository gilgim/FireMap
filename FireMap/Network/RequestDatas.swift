//
//  RequestDatas.swift
//  FireMap
//
//  Created by KimWooJin on 2023/02/09.
//

import Foundation

enum AuthKey: String {
    case encodeKey = "jboqqn37tnIR0z6Ce61cbeXXvPQi5gPXhLckZ1NngKu%2FO9xZU%2FvJQ4%2B0i5O5ecSlInbPRp4dHdVWYYM1gbtSNw%3D%3D"
    case decodeKey = "jboqqn37tnIR0z6Ce61cbeXXvPQi5gPXhLckZ1NngKu/O9xZU/vJQ4+0i5O5ecSlInbPRp4dHdVWYYM1gbtSNw=="
}
enum DataType: String {
    case xml, json
}

/// 시도별 화재 발생 현황
struct reqCityFire: Encodable {
    var pageNo: String
    var numOfRows: String
    var resultType: String
    var serviceKey: String
    var ocrn_ymd: String
    init(pageNo: String, numOfRows: String, resultType: DataType, serviceKey: AuthKey, ocrn_ymd: String) {
        self.pageNo = pageNo
        self.numOfRows = numOfRows
        self.resultType = resultType.rawValue
        self.serviceKey = serviceKey.rawValue
        self.ocrn_ymd = ocrn_ymd
    }
}

extension Encodable {
    var dictionaryValue: [String:String]? {
        guard let object = try? JSONEncoder().encode(self)
        else {
            Util.error_print(title: "Encode to Json Error", #file, #function, #line)
            return nil
        }
        guard let dictionary = try? JSONSerialization.jsonObject(with: object, options: []) as? [String:String]
        else {
            Util.error_print(title: "Json to dictionary Error", #file, #function, #line)
            return nil
        }
        return dictionary
    }
}
