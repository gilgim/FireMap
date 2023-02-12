//
//  Request.swift
//  FireMap
//
//  Created by KimWooJin on 2023/02/09.
//

import Foundation
import Combine

class Network<T: Decodable> {
	public var values: [T]?
	public var header: Response<Body<Items<T>>>.Header?
	public var body: Body<Items<T>>?
	public var subscriber: (any Subscriber)? = nil
	var subscriptionSet: Set<AnyCancellable> = []
	func request(path: FireInfoURL, query: [String:String], file: String = #file, function: String = #function, line: Int = #line) {
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
		URLSession.shared
            .dataTaskPublisher(for: requsetURL)
			.catch({ error in
				URLSession.shared.dataTaskPublisher(for: requsetURL)
			})
            .tryMap { output -> Data in
                guard let httpResponse = output.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return output.data
            }
            .decode(type: CommonDecodable<Response<Body<Items<T>>>>.self, decoder: JSONDecoder())
            .sink(receiveCompletion:{	completion in
				print("URL Path ===> \(urlComponent.path)")
				switch completion {
				case.finished:
					print("finish.")
				case.failure(let error):
					print("error : \(error.localizedDescription)")
				}
			},receiveValue: {	values in
				Util.custom_print(title:"Network")
				print("URL Path ===> \(urlComponent.path)")
				print("<Header>")
				if let header = values.response.header {
					print("result code ===> \(header.resultCode)")
					print("result message ===> \(header.resultMsg)")
				}
				else {
					print("Header isn't exist.")
				}
				
				print("<Body>")
				let body = values.response.body
				print("total count ===> \(body.totalCount)")
				print("num of rows ===> \(body.numOfRows)")
				print("page number ===> \(body.pageNo)")
				
				guard let values = values.response.body.items?.item else {
					Util.error_print(title: "Value Empty Error", file, function, line)
					return
				}
				values.publisher.sink { value in
					print(value)
				}.store(in: &self.subscriptionSet)
				if let subscriber = self.subscriber {
					values.publisher.subscribe(subscriber<[T], Never>)
				}
			})
			.store(in: &subscriptionSet)
    }
}
