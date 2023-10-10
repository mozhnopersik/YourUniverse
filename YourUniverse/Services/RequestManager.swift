//
//  RequestManager.swift
//  YourUniverse
//
//  Created by Вероника Карпова on 10.10.2023.
//

import Alamofire

class RequestManager {
    static let shared = RequestManager()
    
    private init() {}
    
    func fetchAPOD(completion: @escaping (Result<APODResponse, Error>) -> Void) {
        let apiKey = "06TYZxFGt6QiKk3vzx1b8HY84T1EPFastsiLQ783"
        let apodURL = "https://api.nasa.gov/planetary/apod?api_key=\(apiKey)"
        
        AF.request(apodURL).responseDecodable(of: APODResponse.self) { response in
            switch response.result {
            case .success(let apodResponse):
                completion(.success(apodResponse))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
