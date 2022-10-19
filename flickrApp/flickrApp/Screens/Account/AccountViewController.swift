//
//  AccountViewController.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 18.10.2022.
//

import UIKit
import FirebaseAuth

class AccountViewController: CAViewController {
    
    private let viewModel: AccountViewModel
       
       private var isAnyCoinAddedToFavorites: Bool = true
    
    @IBOutlet private weak var tableView:UITableView!
    
    // MARK: - Init
       init(viewModel: AccountViewModel) {
           self.viewModel = viewModel
           super.init(nibName: nil, bundle: nil)
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Profile"
        
        
         let nib = UINib(nibName: "PhotoTableViewCell", bundle: nil)
         tableView.register(nib, forCellReuseIdentifier: "photocell")
         
         //fetchFavorites()
        tableView.delegate=self
        tableView.dataSource = self
         
         NotificationCenter().addObserver(self,
                                          selector: #selector(self.didAnyCoinAddedToFavorites),
                                          name: NSNotification.Name("didAnyCoinAddedToFavorites"),
                                          object: nil)
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isAnyCoinAddedToFavorites = true
        fetchFavorites()
    }
    
    @IBAction private func didTapSignOutButton(_ sender: UIButton) {
        self.showAlert(title: "Warning",
                      message: "Are you sure to sign out?",
                      cancelButtonTitle: "Cancel") { _ in
                do {
                    try Auth.auth().signOut()
                    self.navigationController?.popToRootViewController(animated: true)
                } catch {
                    self.showError(error)
                }
            }
        }
    
    // MARK: - Methods
       private func fetchFavorites() {
           if isAnyCoinAddedToFavorites {
               isAnyCoinAddedToFavorites = false
               viewModel.fetchFavorites { error in
                   if let error = error {
                       self.showError(error)
                   } else {
                       self.tableView.reloadData()
                   }
               }
           }
       }

   
    
    @objc private func didAnyCoinAddedToFavorites() {
            isAnyCoinAddedToFavorites = true
        }
}
// MARK: - UITableViewDelegate
extension AccountViewController: UITableViewDelegate { }

// MARK: - UITableViewDataSource
extension AccountViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // swiftlint:disable force_cast
        // disabled code comes here
        // swiftlint:enable force_cast
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "photocell", for: indexPath) as? PhotoTableViewCell else {
            fatalError("PhotoCollectionViewCell not found.")
        }
        guard let photo = viewModel.photoForIndexPath(indexPath) else {
            fatalError("coin not found.")
        }
        
        cell.title = photo.title
            let photoUrl = "https://live.staticflickr.com/\(photo.server)/\(photo.id)_\(photo.secret).jpg"
            cell.photoImageView.kf.setImage(with: URL(string: photoUrl))
        
        return cell
    }
}
