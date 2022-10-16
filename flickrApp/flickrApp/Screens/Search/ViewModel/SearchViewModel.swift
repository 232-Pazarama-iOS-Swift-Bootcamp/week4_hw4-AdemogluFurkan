//
//  SearchViewModel.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 15.10.2022.
//

import Foundation
import Moya

enum PhotoSearchChanges{
    case didErrorOccured(_ error:Error)
    case didFetchPhotos
}

final class SearchViewModel{
    private let provider = MoyaProvider<FlickrAPI>()
    
    var changeHandler: ((PhotoSearchChanges) -> Void)?
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
    
    func getSearchedPhotos(text:String){
        provider.request(.searchPhoto(text: text)){result in
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
