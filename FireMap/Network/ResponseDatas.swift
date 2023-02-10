//
//  ResponseDatas.swift
//  FireMap
//
//  Created by KimWooJin on 2023/02/09.
//

import Foundation
enum CodingKeys: CodingKey {
    case response, body, items, item
}
struct CommonDecodable<T: Decodable>: Decodable {
    let response: T
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        response = try container.decode(T.self, forKey: .response)
    }
}

struct Response<T: Decodable>: Decodable {
    let header: Header?
    struct Header: Decodable {
        let resultCode: String
        let resultMsg: String
    }
    let body: T
    init(from decoder: Decoder, header: Header) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.body = try container.decode(T.self, forKey: .body)
        self.header = header
    }
}

struct Body<T: Decodable>: Decodable {
    let pageNo: Int
    let totalCount: Int
    let numOfRows: Int
    let items: T?
    init(from decoder: Decoder, pageNo: Int, totalCount: Int, numOfRows: Int) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode(T.self, forKey: .items)
        self.pageNo = pageNo
        self.numOfRows = numOfRows
        self.totalCount = totalCount
    }
}

struct Items<T: Decodable>: Decodable {
    let item: [T]?
}
struct resCityFire: Decodable {
    /// 허위 신고 건수
    let falsDclrMnb: Int
    /// 화재 진행 건수
    let flsrpPrcsMnb: Int
    /// 화재 접수 건수
    let fireRcptMnb: Int
    /// 발생일자
    let ocrnYmd: String
    /// 시도명
    let sidoNm: String
    /// 자체진화건수
    let slfExtshMnb: Int
    /// 상황종료건수
    let stnEndMnb: Int
}
//  TODO: 1. URLSession Combine으로 구현하기 2. 데이터 불러와서 UI 및 위젯 구성하기
