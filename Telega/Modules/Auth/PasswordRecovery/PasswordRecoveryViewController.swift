//
//  PasswordRecoveryViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 14.07.2022.
//

import UIKit
import SkyFloatingLabelTextField

final class PasswordRecoveryViewController: UIViewController {
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
        label.text = "Password recovery"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    // swiftlint:disable line_length
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = .white
        label.text = "Please enter your email, phone or login and we will send a short code to restore your Totem account"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    // swiftlint:enable line_length
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: Self.contentViewCornerRadius)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var phoneNumberTextField: SkyFloatingLabelTextField = {
        let textField = SkyFloatingLabelTextField()
        textField.placeholder = "Phone Number or Email addresss"
        textField.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        textField.selectedLineColor = .lightGray
        textField.selectedTitleColor = .darkGray
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
        button.backgroundColor = .deepSkyBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 6
        button.alpha = 0.5
        button.addTarget(self, action: #selector(contineButtonDidPress), for: .touchUpInside)
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
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        view.backgroundColor = .deepSkyBlue
        
        [backButton, titleLabel, subtitleLabel, contentView].forEach {
            scrollView.addSubview($0)
        }
        
        [phoneNumberTextField, continueButton].forEach {
            contentView.addSubview($0)
        }
        
        view.addSubview(scrollView)
    }
    
    // MARK: - Constraint Offsets
    
    private static let viewInsets = UIEdgeInsets(top: 20, left: 20, bottom: 0, right: 20)
    private static let verticalContentOffset: CGFloat = 30
    private static let contentViewCornerRadius: CGFloat = 30
    private static let totemTypeViewHeight: CGFloat = 90
    private static let buttonHeight: CGFloat = 46
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeTopAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: Self.viewInsets.top),
            backButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Self.viewInsets.left)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: Self.verticalContentOffset),
            titleLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: Self.viewInsets.left)
        ])
        
        NSLayoutConstraint.activate([
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,
                                                    constant: -Self.viewInsets.right)
        ])
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Self.viewInsets.top),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.safeBottomAnchor)
        ])
        
        setupContentViewConstraints()
    }
    
    private func setupContentViewConstraints() {
        NSLayoutConstraint.activate([
            phoneNumberTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                          constant: Self.viewInsets.left),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                           constant: -Self.viewInsets.right)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.viewInsets.left),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Self.viewInsets.right),
            continueButton.heightAnchor.constraint(equalToConstant: Self.buttonHeight)
        ])
    }
    
    // MARK: - Actions
    
    @objc func backButtonDidPress(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func contineButtonDidPress(_ sender: UIButton) {
        navigationController?.pushViewController(OTPViewController(), animated: true)
    }
}
