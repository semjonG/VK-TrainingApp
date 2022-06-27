//
//  NewsAPI.swift
//  VK-TrainingApp
//
//  Created by mac on 20.06.2022.
//

import Foundation
// класс-сервис (класс с бизнес логикой, туда будем складывать запросы для фотографий)

class NewsAPI {

    func fetchNews(offset: Int = 0, completion: @escaping (Result<[NewsItem], Error>) -> ()) {

        var components = URLComponents()
        components.scheme = "HTTPS"
        components.host = "api.vk.com"
        components.path = "/method/newsfeed.get"
        components.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userID)"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = components.url else { return }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"

        URLSession.shared.dataTask(with: urlRequest) { data, response, error in

//            print(data?.prettyPrintedJSONString) // если не получится с проксимен

            guard let data = data, error == nil else { return }

            let decoder = JSONDecoder()
            do {
                let newsJSON = try decoder.decode(NewsJSON.self, from: data)
                let news = newsJSON.response?.items

                DispatchQueue.main.async {
                    completion(.success(news ?? []))
                }

            } catch {
                completion(.failure(error))
            }
            completion(.success([]))
        }.resume()
    }
}
