//
//  NewsAPI.swift
//  VK-TrainingApp
//
//  Created by mac on 20.06.2022.
//

import Foundation
// класс-сервис (класс с бизнес логикой, туда будем складывать запросы для фотографий)

final class NewsAPI {

    func fetchNews(offset: Int = 0, completion: @escaping (Result<[PostCellModel], Error>) -> ()) {

        var components = URLComponents()
        components.scheme = "HTTPS"
        components.host = "api.vk.com"
        components.path = "/method/newsfeed.get"
        components.queryItems = [
            URLQueryItem(name: "owner_id", value: "\(Session.shared.userID)"),
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "count", value: "50"),
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
                let newsItems = newsJSON.response?.items ?? [] // массив новостей
                
                let profiles = newsJSON.response?.profiles ?? []
                let groups = newsJSON.response?.groups ?? []
                
                var postModels: [PostCellModel] = []
                for post in newsItems {
                    
                    if post.type != "post" { continue }
                    
                    var authorName = ""
                    var authorImageUrl = ""
                    
                    let sourceID = post.sourceID ?? 0
                    
                    if sourceID < 0 {
                        let group = groups.first { $0.id == abs(sourceID) }
                        authorName = group?.name ?? ""
                        authorImageUrl = group?.photo100 ?? ""
                    } else {
                        let profile = profiles.first { $0.id == sourceID }
                        authorName = "\(profile?.firstName ?? "") \(profile?.lastName ?? "")"
                        authorImageUrl = profile?.photo100 ?? ""
                    }
                    
                    let photoUrl = post.attachments?.first?.photo?.sizes?.last?.url ?? ""
                    
                    let text = post.text ?? ""
                    
                    let likesCount = post.likes?.count ?? 0
                    
                    let postModel = PostCellModel(authorImageUrl: authorImageUrl,
                                                  authorName: authorName,
                                                  text: text,
                                                  photoUrl: photoUrl,
                                                  likesCount: likesCount)
                    
                    postModels.append(postModel)
                    
                }
                
                print(postModels)
                
                DispatchQueue.main.async {
                    completion(.success(postModels))
                }

            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
