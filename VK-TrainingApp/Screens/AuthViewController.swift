//
//  ViewController.swift
//  VK-TrainingApp
//
//  Created by mac on 26.04.2022.
//

import UIKit
import WebKit

final class AuthViewController: UIViewController, WKNavigationDelegate {
    
//    MARK: - Outlets
    
    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }
    
    //    MARK: - Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorizeToAPI()
    }
    
    /*
     https://oauth.vk.com/authorize
     ?client_id=1
     &display=page
     &redirect_uri=http://example.com/callback
     &scope=friends
     &response_type=token
     &v=5.131
     &state=123456
     */
    
    func authorizeToAPI() {
        
//        1. собираем URL в конструкторе
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
        URLQueryItem(name: "client_id", value: "7822904"),
        URLQueryItem(name: "display", value: "mobile"),
        URLQueryItem(name: "redirect_uri", value: "https://oath.vk.com/blank.html"),
        URLQueryItem(name: "scope", value: "271366"),
        URLQueryItem(name: "response_type", value: "token"),
        URLQueryItem(name: "revoke", value: "1"),
        URLQueryItem(name: "v", value: "5.131"),
        URLQueryItem(name: "state", value: "1"),
        ]
        
//        2. создаем запрос
        let request = URLRequest(url: urlComponents.url!)
        
//        2.1 браузер отправляет запрос
        webView.load(request)
    }
    
//    получение обратного запроса
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html" else {
            print(navigationResponse.response.url)
            
            decisionHandler(.allow)
            return
        }
        
        let paramsDictionary = url
            .fragment?
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { partialResult, param in
                var dictionary = partialResult
                let key = param[0]
                let value = param[1]
                dictionary[key] = value
                return dictionary
            }
        
        guard let token = paramsDictionary?["access_token"],
              let userID = paramsDictionary?["user_id"],
              let expiresIn = paramsDictionary?["expires_in"] else { return }
        
        Session.shared.token = token
        Session.shared.expiresIn = Int(expiresIn) ?? 0
        Session.shared.userID = Int(userID) ?? 0
        
        let tabBarController = TabBarController()
        navigationController?.pushViewController(tabBarController, animated: true)
        
        navigationController?.isNavigationBarHidden = true
        
        decisionHandler(.cancel)
    }
}

