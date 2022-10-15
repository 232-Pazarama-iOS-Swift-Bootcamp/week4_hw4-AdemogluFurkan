//
//  FlickrApi.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 13.10.2022.
//

import Moya

enum FlickrAPI{
    case recentPhotos
}

extension FlickrAPI:TargetType{
    var baseURL: URL {
        guard let url = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=bd22827f865f91809f563c04557356cd&format=json&nojsoncallback=1&auth_token=72157720860775600-6007be594f0b3ab3&api_sig=7db4789b40c307679661b931988edb6f") else{
            fatalError("Base URL not found or not in correct format.")
        }
        return url
    }
    
    var path: String {
        switch self{
        case .recentPhotos:
            return ""
        }
    }
    
    var method: Method {
        .get
    }
    
    var task: Task {
        switch self{
        case .recentPhotos:
           /* let parameters = ["method":"flickr.photos.getRecent",
                              "api_key":"f36ac47a11d74c27888a43d0fe485b76"
            ]*/
            //return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        nil
    }
    
    
}
