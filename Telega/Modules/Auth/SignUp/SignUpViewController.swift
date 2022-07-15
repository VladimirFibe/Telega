//
//  SignUpViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 14.07.2022.
//

import UIKit
import SkyFloatingLabelTextField

final class SignUpViewController: UIViewController {
    // MARK: - UI Components
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back_icon"), for: .normal)
        button.tintColor = .white
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 20)
        button.addTarget(self, action: #selector(backButtonDidPress), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Bold", size: 22)
        label.textColor = .white
        label.text = "Sign Up"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = .white
        label.text = "Please login to continue using our app"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var totemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "create_totem_background_image")
        imageView.tintColor = .white
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = .deepSkyBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner],
                          radius: Self.contentViewCornerRadius)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var genderTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .scorpion
        label.text = "I am"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var genderSegmentControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Boy", "Girl"])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(segmentControlDidChange(_:)), for: .valueChanged)
        control.translatesAutoresizingMaskIntoConstraints = false
        
        return control
    }()
    
    private lazy var avatarView: SignUpAvatarView = {
        let view = SignUpAvatarView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        return view
    }()
    
    private lazy var nameTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Name"
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        textField.selectedLineColor = .lightGray
        textField.selectedTitleColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var phoneNumberTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Phone Number or Email address"
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        textField.selectedLineColor = .lightGray
        textField.selectedTitleColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var passwordTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Password"
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        textField.selectedLineColor = .lightGray
        textField.selectedTitleColor = .darkGray
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Login to my account", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
        button.backgroundColor = .deepSkyBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(loginButtonDidPress), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        setupViews()
        setupConstraints()
    }
    
    // MARK: - Configure Navigation Bar
    
    private func configureNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Status Bar
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .white
        [backButton, titleLabel, subtitleLabel, totemImageView].forEach {
            headerView.addSubview($0)
        }
        
        [headerView, contentView].forEach {
            scrollView.addSubview($0)
        }
        
        [genderTitleLabel, genderSegmentControl, avatarView, nameTextField,
         phoneNumberTextField, passwordTextField, signUpButton].forEach {
            contentView.addSubview($0)
        }
        
        view.addSubview(scrollView)
        let statusBarView = UIView(frame: UIApplication.shared.statusBarFrame)
        statusBarView.backgroundColor = .deepSkyBlue
        view.addSubview(statusBarView)
    }
    
    // MARK: - Constraint Offsets
    
    private static let viewInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    private static let verticalContentOffset: CGFloat = 16
    private static let contentViewCornerRadius: CGFloat = 30
    private static let totemImageViewSize = CGSize(width: 123, height: 127)
    private static let buttonHeight: CGFloat = 46
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            headerView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: headerView.topAnchor, constant: Self.viewInsets.top),
            backButton.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Self.viewInsets.left)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButton.topAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: Self.viewInsets.left),
            titleLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -Self.viewInsets.left)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            totemImageView.topAnchor.constraint(equalTo: headerView.topAnchor),
            totemImageView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            totemImageView.widthAnchor.constraint(equalToConstant: Self.totemImageViewSize.width),
            totemImageView.heightAnchor.constraint(equalToConstant: Self.totemImageViewSize.height)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: totemImageView.bottomAnchor, constant: Self.viewInsets.top),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        
        setupContentViewConstraints()
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            genderTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 28),
            genderTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                      constant: Self.viewInsets.left),
            genderTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                       constant: -Self.viewInsets.right)
        ])
        
        NSLayoutConstraint.activate([
            genderSegmentControl.topAnchor.constraint(equalTo: genderTitleLabel.bottomAnchor, constant: 8),
            genderSegmentControl.leadingAnchor.constraint(equalTo: genderTitleLabel.leadingAnchor),
            genderSegmentControl.trailingAnchor.constraint(equalTo: genderTitleLabel.trailingAnchor),
            genderSegmentControl.heightAnchor.constraint(equalToConstant: 42)
        ])
        
        NSLayoutConstraint.activate([
            avatarView.topAnchor.constraint(equalTo: genderSegmentControl.bottomAnchor,
                                            constant: Self.verticalContentOffset),
            avatarView.leadingAnchor.constraint(equalTo: genderTitleLabel.leadingAnchor),
            avatarView.trailingAnchor.constraint(equalTo: genderTitleLabel.trailingAnchor),
            avatarView.heightAnchor.constraint(equalToConstant: 96.5)
        ])
        
        NSLayoutConstraint.activate([
            nameTextField.topAnchor.constraint(equalTo: avatarView.bottomAnchor,
                                               constant: Self.verticalContentOffset),
            nameTextField.leadingAnchor.constraint(equalTo: genderTitleLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: genderTitleLabel.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor,
                                                      constant: Self.verticalContentOffset),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor,
                                                   constant: Self.verticalContentOffset),
            passwordTextField.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            signUpButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor,
                                              constant: Self.verticalContentOffset),
            signUpButton.leadingAnchor.constraint(equalTo: nameTextField.leadingAnchor),
            signUpButton.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor),
            signUpButton.heightAnchor.constraint(equalToConstant: Self.buttonHeight),
            signUpButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                 constant: -Self.verticalContentOffset)
        ])
    }
    
    // MARK: - Actions
    
    @objc private func loginButtonDidPress() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: nil)
    }
    
    @objc private func segmentControlDidChange(_ sender: UISegmentedControl) {
        avatarView.gender = sender.selectedSegmentIndex
    }
    
    @objc private func backButtonDidPress() {
        navigationController?.popViewController(animated: true)
    }
}

extension SignUpViewController: AvatarViewDelegate {
    func addPhotoDidClick() {
//        checkPhotoLibraryPermission { _ in }
    }
}
