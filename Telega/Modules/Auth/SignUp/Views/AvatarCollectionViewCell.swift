//
//  AvatarCollectionViewCell.swift
//  Telega
//
//  Created by Vladimir Fibe on 14.07.2022.
//

import UIKit

final class AvatarCollectionViewCell: UICollectionViewCell {
    // MARK: - UI Components
    
    public lazy var borderView: UIView = {
        let view = UIView()
        view.layer.masksToBounds = true
        view.backgroundColor = .clear
        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 3
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    public lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    // MARK: - Lifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        avatarImageView.image = UIImage(named: "default_avatar")
    }
    
    override var isSelected: Bool {
        didSet {
            borderView.layer.borderColor = isSelected ? UIColor.deepSkyBlue.cgColor : UIColor.clear.cgColor
            borderView.layer.cornerRadius = borderView.bounds.width / 2
        }
    }
    
    // MARK: - Setup Views
    
    private func setupViews() {
        contentView.addSubview(borderView)
        borderView.addSubview(avatarImageView)
    }
    
    // MARK: - Constraint Offsets
    
    private static let borderViewInsets = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
    private static let avatarImageViewInsets = UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6)
    
    // MARK: - Setup Constraints
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            borderView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Self.borderViewInsets.top),
            borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                constant: Self.borderViewInsets.left),
            borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                 constant: -Self.borderViewInsets.right),
            borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                               constant: -Self.borderViewInsets.bottom)
        ])
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: borderView.topAnchor,
                                                 constant: Self.avatarImageViewInsets.top),
            avatarImageView.leadingAnchor.constraint(equalTo: borderView.leadingAnchor,
                                                     constant: Self.avatarImageViewInsets.left),
            avatarImageView.trailingAnchor.constraint(equalTo: borderView.trailingAnchor,
                                                      constant: -Self.avatarImageViewInsets.right),
            avatarImageView.bottomAnchor.constraint(equalTo: borderView.bottomAnchor,
                                                    constant: -Self.avatarImageViewInsets.bottom)
        ])
    }
}
