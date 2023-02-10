//
//  Request.swift
//  FireMap
//
//  Created by KimWooJin on 2023/02/09.
//

import Foundation
import Combine

class Network<T: Decodable> {
    static func request(path: FireInfoURL, query: [String:String], file: String = #file, function: String = #function, line: Int = #line) {
        guard var urlComponent = URLComponents(string: path.fullUrl) else {
            Util.error_print(title: "URLComnentError", file, function, line)
            return
        }
        let urlQueryItems = query.map({
            return URLQueryItem(name: $0.key, value: $0.value)
        })
        urlComponent.queryItems = urlQueryItems
        let url = "\(urlComponent.scheme ?? "http")://"+(urlComponent.host ?? "apis.data.go.kr")+urlComponent.path+"?"+(urlComponent.query ?? "")
        
        guard let requsetURL = URL(string: url) else {
            Util.error_print(title: "URLComponet don't make url", file, function, line)
            return
        }
        URLSession.shared.dataTask(with: requsetURL) { data, response, error in
            guard let data else {return}
            let sample = try? JSONDecoder().decode(CommonDecodable<Response<Body<Items<T>>>>.self, from: data)
            print(sample?.response.body.items?.item)
        }.resume()
        
//        URLSession.shared
//            .dataTaskPublisher(for: requsetURL)
//            .tryMap { output -> Data in
//                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//                    throw URLError(.badServerResponse)
//                }
//                return output.data
//            }
//            .decode(type: CommonDecodable<Response<Body<Items<T>>>>.self, decoder: JSONDecoder())
//            .sink(receiveCompletion: {_ in print("A")}, receiveValue: {_ in print("B")})
    }
}
