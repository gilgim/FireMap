//
//  URI.swift
//  FireMap
//
//  Created by KimWooJin on 2023/02/09.
//

import Foundation

enum FireInfoURL: String {
    /// 시도별 국가 화재 정보
    case getOcBysidoFireSmrzPcnd
    var fullUrl: String {
        let base = "http://apis.data.go.kr/1661000/FireInformationService"
        switch self {
        default:
            return base + "/" + self.rawValue
        }
    }
}

