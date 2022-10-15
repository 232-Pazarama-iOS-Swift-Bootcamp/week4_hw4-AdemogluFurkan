//
//  AuthViewController.swift
//  flickrApp
//
//  Created by Furkan Ademoğlu on 15.10.2022.
//

import UIKit

final class AuthViewController: CAViewController {
    
    private let viewModel: AuthViewModel
    
    
    @IBOutlet weak var emailTextField:UITextField!
    @IBOutlet weak var passwordTextField:UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var confirmButton: UIButton!
    
    
    
       enum AuthType: String {
           case signIn = "Sign In"
           case signUp = "Sign Up"
           
           init(text: String) {
               switch text {
               case "Sign In":
                   self = .signIn
               case "Sign Up":
                   self = .signUp
               default:
                   self = .signIn
               }
           }
       }
       
       var authType: AuthType = .signIn {
           didSet {
               titleLabel.text = title
               confirmButton.setTitle(title, for: .normal)
           }
       }
    
    // MARK: - Init
        init(viewModel: AuthViewModel) {
            self.viewModel = viewModel
            super.init(nibName: nil, bundle: nil)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.changeHandler = { change in
                   switch change {
                   case .didErrorOccurred(let error):
                       self.showError(error)
                   case .didSignUpSuccessful:
                       self.showAlert(title: "SIGN UP SUCCESSFUL!")
                   }
               }
               /*
               flickrApiProvider.request(.getRecentPhotos) { result in
                   switch result {
                   case .failure(let error):
                       print(error.localizedDescription)
                   case .success(let response):
                       print(String(decoding: response.data, as: UTF8.self))
                   }
               }
               */
               title = "Auth"
               
               viewModel.fetchRemoteConfig { isSignUpDisabled in
                   self.segmentedControl.isHidden = isSignUpDisabled
               }
    }

    @IBAction private func didTapLoginButton(_ sender:UIButton){
        guard let credential = emailTextField.text,
                      let password = passwordTextField.text else {
                    return
                }
                switch authType {
                case .signIn:
                    viewModel.signIn(email: credential,
                                     password: password,
                                     completion: { [weak self] in
                        guard let self = self else { return }
                        let photoListViewModel = PhotoListViewModel()
                        let cryptoListViewController = PhotoListViewController(viewModel: photoListViewModel)
                        
                        let tabBarController = UITabBarController()
                        tabBarController.viewControllers = [cryptoListViewController]
                        self.navigationController?.pushViewController(tabBarController, animated: true)
                    })
                case .signUp:
                    viewModel.signUp(email: credential,
                                     password: password)
                }
    }
    
    
    @IBAction private func didValueChangedSegmentedControl(_ sender: UISegmentedControl) {
          let title = segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex)
          authType = AuthType(text: title ?? "Sign In")
      }
   

}
