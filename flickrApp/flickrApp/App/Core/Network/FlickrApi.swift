//
//  FlickrApi.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 13.10.2022.
//

import Moya

enum FlickrAPI{
    case recentPhotos
    case searchPhoto(text:String)
}

extension FlickrAPI:TargetType{
    var baseURL: URL {
        guard let url = URL(string: "https://www.flickr.com/services/rest") else{
            fatalError("Base URL not found or not in correct format.")
        }
        return url
    }
    
    var path: String {
        switch self{
        case .recentPhotos:
            return ""
        case .searchPhoto:
            return ""
        }
    }
    
    var method: Method {
        .get
    }
    
    var task: Task {
        switch self{
        case .recentPhotos:
            let parameters: [String:Any] = ["method":"flickr.photos.getRecent",
                                            "api_key":"bd55e9803148dad0a9e2bf086fee6cfa",
                                            "format":"json",
                                            "nojsoncallback":1
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .searchPhoto(let text):
            let parameters: [String:Any]=["method":"flickr.photos.search",
                                          "api_key":"bd55e9803148dad0a9e2bf086fee6cfa",
                                          "text" : text,
                                          "format":"json",
                                          "nojsoncallback":1
          ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
