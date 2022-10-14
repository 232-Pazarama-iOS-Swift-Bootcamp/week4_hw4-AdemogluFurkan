//
//  PhotoListViewController.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 13.10.2022.
//

import UIKit
import Kingfisher

final class PhotoListViewController: UIViewController {
    
    private var viewModel : PhotoListViewModel
    
    @IBOutlet private weak var tableView:UITableView!

    //MARK: - Init
    init(viewModel:PhotoListViewModel){
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchPhotos()
        
        let nib = UINib(nibName: "PhotoTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "photocell")

        viewModel.changeHandler = { change in
            switch change{
            case .didFetchPhotos:
                self.tableView.reloadData()
            case .didErrorOccured(let error):
                print(error.localizedDescription)
            }
            
        }
    }
}

extension PhotoListViewController:UITableViewDelegate{
    
}

extension PhotoListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "photocell", for: indexPath) as! PhotoTableViewCell
        let photo = viewModel.photoForIndexPath(indexPath)
        cell.title = photo?.title
        let photoUrl = "https://live.staticflickr.com/\(photo?.server)/\(photo?.id)_\(photo?.secret).jpg"
        cell.photoImageView?.kf.setImage(with: URL(string: photoUrl))
        return cell
    }
}
