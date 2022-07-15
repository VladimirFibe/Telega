//
//  SignUpAvatarView.swift
//  Telega
//
//  Created by Vladimir Fibe on 14.07.2022.
//

import UIKit

protocol AvatarViewDelegate: AnyObject {
    func addPhotoDidClick()
}

final class SignUpAvatarView: UIView {
    
    public weak var delegate: AvatarViewDelegate?
    
    // MARK: - Properties
    
    private var selectedImageIndex: IndexPath?
    private var maleDefaultAvatars: [UIImage?] = [UIImage(named: "default_avatar"),
                                                  UIImage(named: "default_avatar_male"),
                                                  UIImage(named: "default_avatar_male-1"),
                                                  UIImage(named: "default_avatar"),
                                                  UIImage(named: "default_avatar")]
    private var femaleDefaultAvatars: [UIImage?] = [UIImage(named: "default_avatar_female"),
                                                    UIImage(named: "default_avatar_female-1"),
                                                    UIImage(named: "default_avatar_female-2")]
    public var gender: Int = 0 {
        didSet {
            collectionView.reloadData()
        }
    }
    
    // MARK: - UI Components
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Montserrat-SemiBold", size: 14)
        label.textColor = .scorpion
        label.text = "My avatar would be"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 6
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 72, height: 72)
        
        return layout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: frame, collectionViewLayout: collectionViewLayout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AvatarCollectionViewCell.self,
                                forCellWithReuseIdentifier: String(describing: AvatarCollectionViewCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        backgroundColor = .red
        [titleLabel, collectionView].forEach {
            addSubview($0)
        }
    }
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

// MARK: UICollectionViewDelegate & UICollectionViewDataSource

extension SignUpAvatarView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let avatarCount = gender == 0 ? maleDefaultAvatars.count : femaleDefaultAvatars.count
        return avatarCount + 1
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let reuseIdentifier = String(describing: AvatarCollectionViewCell.self)
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as? AvatarCollectionViewCell {
            if indexPath.row == 0 {
                cell.avatarImageView.image = UIImage(named: "plus")
            } else {
                cell.avatarImageView.image =
                    gender == 0 ? maleDefaultAvatars[indexPath.row-1] : femaleDefaultAvatars[indexPath.row-1]
            }
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            delegate?.addPhotoDidClick()
            collectionView.deselectItem(at: indexPath, animated: true)
        }
        
        selectedImageIndex = indexPath
    }
}
