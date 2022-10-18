//
//  Photo.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 14.10.2022.
//

import Foundation

struct Photo : Codable {
    let id :String
    let owner:String?
    let secret:String
    let server:String
    let title:String?
    let ispublic:Int?
}

extension Photo {
    init(from dict: [String: Any]) {
        id = dict["id"] as! String
        owner = dict["owner"] as? String
        secret = dict["secret"] as! String
        server = dict["server"] as! String
        title = dict["title"] as! String
        ispublic = dict["ispublic"] as? Int
    }
}
