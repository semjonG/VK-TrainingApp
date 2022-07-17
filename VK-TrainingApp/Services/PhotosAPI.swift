//
//  PhotosAPI.swift
//  VK-TrainingApp
//
//  Created by mac on 14.06.2022.
//

import Foundation
// класс-сервис (класс с бизнес логикой, туда будем складывать запросы для фотографий)
final class PhotosAPI {
    
    func fetchPhotos(offset: Int = 0, completion: @escaping (Result<[Photo], Error>) -> ()) {
        
        var components = URLComponents()
        components.scheme = "HTTPS"
        components.host = "api.vk.com"
        components.path = "/method/photos.getAll"
        components.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userID)"),
            URLQueryItem(name: "extended", value: "1"),
            URLQueryItem(name: "offset", value: "\(offset)"), 
            URLQueryItem(name: "count", value: "30"),
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
                let photosResponse = try decoder.decode(PhotosResponse.self, from: data)
                let photos = photosResponse.response?.items ?? []
                
                DispatchQueue.main.async {
                    completion(.success(photos))
                }
                
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
