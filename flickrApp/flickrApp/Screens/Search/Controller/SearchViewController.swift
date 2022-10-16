//
//  SearchViewController.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 15.10.2022.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var viewModel:SearchViewModel
    
    @IBOutlet  weak var collectionView:UICollectionView!
    
    //MARK: - Init
    init(viewModel:SearchViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController()
                       searchController.searchBar.placeholder = "Search a keyword..."
                       searchController.searchResultsUpdater = self
                       navigationItem.searchController = searchController
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "PhotoCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "searchCell")
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 5
        layout.minimumInteritemSpacing = 5
        collectionView.setCollectionViewLayout(layout, animated: true)
        viewModel.fetchPhotos()
        viewModel.changeHandler = { change in
            switch change{
            case .didFetchPhotos:
                self.collectionView.reloadData()
            case .didErrorOccured(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "searchCell", for: indexPath) as! PhotoCollectionViewCell
        let photo = viewModel.photoForIndexPath(indexPath)
        cell.searchLabel.text=photo?.title
        if let unwarrapedPhoto = photo{
            let photoUrl = "https://live.staticflickr.com/\(unwarrapedPhoto.server)/\(unwarrapedPhoto.id)_\(unwarrapedPhoto.secret).jpg"
            cell.searchImage.kf.setImage(with: URL(string: photoUrl))
        }
       
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            viewModel.getSearchedPhotos(text: text)
        }
    }
}
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 1.0, left: 1.0, bottom: 1.0, right: 1.0)
    }
func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let gridLayout = collectionViewLayout as! UICollectionViewFlowLayout
    let widthPerItem = collectionView.frame.width / 2 - gridLayout.minimumInteritemSpacing
    return CGSize(width:widthPerItem, height:300)
}
}
