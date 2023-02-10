//
//  CityFireModel.swift
//  FireMap
//
//  Created by KimWooJin on 2023/02/10.
//

import Foundation

class CityFireModel {
    func cityFireRequest(_ file: String = #file, _ function: String = #function, _ line: Int = #line) {
        guard let query = reqCityFire(pageNo: "1", numOfRows: "10", resultType: .json, serviceKey: .encodeKey, ocrn_ymd: "20201106").dictionaryValue else {
            Util.error_print(title: "Query to dic error", file, function, line)
            return
        }
        Network<resCityFire>.request(path: .getOcBysidoFireSmrzPcnd, query: query)
    }
}
