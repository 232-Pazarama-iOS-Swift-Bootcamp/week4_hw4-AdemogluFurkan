//
//  Photo.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 14.10.2022.
//

import Foundation

struct Photo : Decodable {
    let id :String?
    let owner:String?
    let secret:String?
    let server:String?
    let title:String?
    let ispublic:Int?
}
