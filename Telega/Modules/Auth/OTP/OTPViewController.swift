//
//  OTPViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 14.07.2022.
//

import UIKit
import KKPinCodeTextField

final class OTPViewController: UIViewController {
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
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = .white
        label.text = "We have sent to this phone number a code. Just submit it"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.roundCorners([.layerMinXMinYCorner, .layerMaxXMinYCorner], radius: Self.contentViewCornerRadius)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var pinCodeTextField: KKPinCodeTextField = {
        let pinCodeTextField = KKPinCodeTextField()
        pinCodeTextField.borderHeight = 3
        pinCodeTextField.digitsCount = 4
        pinCodeTextField.bordersSpacing = 20
        pinCodeTextField.emptyDigitBorderColor = .darkGray
        pinCodeTextField.filledDigitBorderColor = .lightGray
        pinCodeTextField.font = UIFont.systemFont(ofSize: 50)
        pinCodeTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return pinCodeTextField
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
        button.backgroundColor = .deepSkyBlue
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(contineButtonDidPress), for: .touchUpInside)
        button.layer.cornerRadius = 6
        button.isEnabled = false
        button.alpha = 0.5
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var getNewCodeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get a new code", for: .normal)
        button.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 12)
        button.backgroundColor = .white
        button.setTitleColor(.deepSkyBlue, for: .normal)
        button.addTarget(self, action: #selector(getNewCodeButtonDidPress), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var countdownLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-Regular", size: 13)
        label.textColor = .mountainMist
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    // MARK: - Variables
    
    private lazy var timer: Timer? = nil
    private var seconds = 60
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        setupViews()
        setupConstraints()
        runTimer()
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
        
        [pinCodeTextField, continueButton, getNewCodeButton, countdownLabel].forEach {
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
            pinCodeTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.viewInsets.top),
            pinCodeTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pinCodeTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: pinCodeTextField.bottomAnchor, constant: 32),
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Self.viewInsets.left),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                    constant: -Self.viewInsets.right),
            continueButton.heightAnchor.constraint(equalToConstant: Self.buttonHeight)
        ])
        
        NSLayoutConstraint.activate([
            getNewCodeButton.topAnchor.constraint(equalTo: continueButton.bottomAnchor, constant: Self.viewInsets.top),
            getNewCodeButton.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
            getNewCodeButton.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor),
            getNewCodeButton.heightAnchor.constraint(equalToConstant: Self.buttonHeight)
        ])
        
        NSLayoutConstraint.activate([
            countdownLabel.topAnchor.constraint(equalTo: getNewCodeButton.topAnchor),
            countdownLabel.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
            countdownLabel.trailingAnchor.constraint(equalTo: continueButton.trailingAnchor),
            countdownLabel.bottomAnchor.constraint(equalTo: getNewCodeButton.bottomAnchor)
        ])
    }
    
    // MARK: - Timer
    
    private func runTimer() {
        getNewCodeButton.isHidden = true
        countdownLabel.isHidden = false
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer),
                                     userInfo: nil, repeats: true)
    }
    
    private func timeString(time:TimeInterval) -> String {
        let minutes = Int(time) / 60 % 60
        let seconds = Int(time) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - Actions
    
    @objc func backButtonDidPress(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func contineButtonDidPress(_ sender: UIButton) {}
    
    @objc func getNewCodeButtonDidPress(_ sender: UIButton) {
        runTimer()
    }
    
    @objc func updateTimer() {
        seconds -= 1
        
        if seconds <= 0 {
            timer?.invalidate()
            countdownLabel.isHidden = true
            getNewCodeButton.isHidden = false
            seconds = 60
            countdownLabel.text = "Новый код будет доступен через \(timeString(time: TimeInterval(seconds)))"
            return
        }
        
        countdownLabel.text = "Новый код будет доступен через \(timeString(time: TimeInterval(seconds)))"
    }
}
