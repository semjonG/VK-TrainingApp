//
//  FriendsAPI.swift
//  VK-TrainingApp
//
//  Created by mac on 04.06.2022.
//

import Foundation

class FriendsAPI {
// https://api.vk.com/method/METHOD?PARAMS&access_token=TOKEN&v=V
    
    func fetchFriends(completion: @escaping (Result<[Friend], Error>) -> ()) {
        
        var components = URLComponents()
        components.scheme = "HTTPS"
        components.host = "api.vk.com"
        components.path = "/method/friends.get"
        components.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userID)"),
            URLQueryItem(name: "order", value: "random"),
            URLQueryItem(name: "count", value: "5"),
            URLQueryItem(name: "offset", value: "0"),
            URLQueryItem(name: "fields", value: "bdate, city, education, nickname, online, photo_100, relation, sex"),
            URLQueryItem(name: "access_token", value: "\(Session.shared.token)"),
            URLQueryItem(name: "v", value: "5.131")
        ]
        
        guard let url = components.url else { return }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            // data - JSON, завернутый в бинарник (вытаскиваем из body-тела ответа)
            
            print(data?.prettyPrintedJSONString)
            
            guard let data = data, error == nil else { return }
            
            let decoder = JSONDecoder()
            do {
                let friendsResponse = try decoder.decode(FriendsResponse.self, from: data)
                let friends = friendsResponse.response?.items ?? []
                
                // ставим задачу в очередь на главный поток 
                DispatchQueue.main.async {
                    completion(.success(friends))
                }
                
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


