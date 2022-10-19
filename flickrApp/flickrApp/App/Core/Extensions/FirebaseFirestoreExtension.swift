//
//  FirebaseFirestoreExtension.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 18.10.2022.
//

import Foundation
import FirebaseFirestore

protocol FireBaseFireStoreAccessible {}

extension FireBaseFireStoreAccessible {
    var db: Firestore {
        Firestore.firestore()
    }
}
