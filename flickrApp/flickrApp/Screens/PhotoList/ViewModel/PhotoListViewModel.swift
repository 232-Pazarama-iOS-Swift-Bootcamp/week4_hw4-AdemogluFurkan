//
//  PhotoListViewModel.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 13.10.2022.
//

import Foundation
import Moya

enum PhotoListChanges{
    case didErrorOccured(_ error:Error)
    case didFetchPhotos
}

final class PhotoListViewModel{
    private let provider = MoyaProvider<FlickrAPI>()
    
    var changeHandler: ((PhotoListChanges) -> Void)?
    var numberOfRows:Int{
        photosResponse?.photos?.photo?.count ?? .zero
    }
    private var photosResponse : PhotoResponse?{
        didSet{
            self.changeHandler?(.didFetchPhotos)
        }
    }
    
    func fetchPhotos(){
        provider.request(.recentPhotos){result in
            switch result{
            case .failure(let error):
                self.changeHandler?(.didErrorOccured(error))
            case .success(let response):
                
                do{
                    let photosResponse = try? JSONDecoder().decode(PhotoResponse.self, from: response.data)
                    self.photosResponse = photosResponse
                    self.changeHandler?(.didFetchPhotos)
                } catch{
                    self.changeHandler?(.didErrorOccured(error))
                }
            }
        }
    }
    
    func photoForIndexPath(_ indexPath:IndexPath) -> Photo?{
        photosResponse?.photos?.photo?[indexPath.row]
    }
    
}
