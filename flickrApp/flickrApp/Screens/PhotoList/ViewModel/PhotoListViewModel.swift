//
//  PhotoListViewModel.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 13.10.2022.
//

import Foundation
import Moya
import FirebaseFirestore


@objc
protocol PhotoListDelegate: AnyObject{
    @objc optional func didCoinAddedToFavorites()
}

enum PhotoListChanges{
    case didErrorOccured(_ error:Error)
    case didFetchPhotos
}

final class PhotoListViewModel{
    weak var delegate:PhotoListDelegate?
    
    private let db = Firestore.firestore()
    private let defaults = UserDefaults.standard
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
                    self.addImagesToFirebaseFirestore(photosResponse?.photos?.photo)
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
    
    func addFavorite(photo:Photo?) {
          guard let id = photo?.id,
                let uid = defaults.string(forKey: UserDefaultConstants.uid.rawValue) else {
              return
          }
          
          db.collection("users").document(uid).updateData([
              "favorites": FieldValue.arrayUnion([id])
          ])
          
          delegate?.didCoinAddedToFavorites?()
      }
    
    private func addImagesToFirebaseFirestore(_ photos: [Photo]?) {
            guard let photos = photos else {
                return
            }
            photos.forEach { photo in
                do {
                    guard let data = try photo.dictionary else {
                        return
                    }
                    let id = photo.id
                    db.collection("photos").document(id).setData(data) { error in
                        
                        if let error = error {
                            self.changeHandler?(.didErrorOccured(error))
                        }
                    }
                } catch {
                    self.changeHandler?(.didErrorOccured(error))
                }
            }
        }
        
    
}
