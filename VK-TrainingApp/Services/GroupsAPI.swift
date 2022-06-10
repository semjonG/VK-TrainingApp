//
//  GroupsAPI.swift
//  VK-TrainingApp
//
//  Created by mac on 08.06.2022.
//

import Foundation

class GroupsAPI {
    
    func fetchGroups(offset: Int = 0, completion: @escaping (Result<[Group], Error>) -> ()) {
        var components = URLComponents()
        components.scheme = "HTTPS"
        components.host = "api.vk.com"
        components.path = "/method/groups.get"
        components.queryItems = [
            URLQueryItem(name: "user_id", value: "\(Session.shared.userID)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "offset", value: "\(offset)"), // загружаем группы с нулевого индекса, подставляя 20 - будем начинать с 20ой группы
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
                let groupsResponse = try decoder.decode(GroupsResponse.self, from: data)
                let groups = groupsResponse.response?.items ?? []
                
                DispatchQueue.main.async {
                    completion(.success(groups))
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
