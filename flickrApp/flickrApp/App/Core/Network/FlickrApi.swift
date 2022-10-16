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
                                            "api_key":"3251950b2f84f909042bcf2c93c9d216",
                                            "format":"json",
                                            "nojsoncallback":1
            ]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        case .searchPhoto(let text):
            let parameters: [String:Any]=["method":"flickr.photos.search",
                                          "api_key":"3251950b2f84f909042bcf2c93c9d216",
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
