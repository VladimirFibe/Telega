//
//  ViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
  var messages = Message.all
  
  let layout: ChatFlowLayout = {
    $0.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    $0.minimumLineSpacing = 10
    $0.minimumInteritemSpacing = 10
    return $0
  }(ChatFlowLayout())
  
  lazy var collectionView: UICollectionView = {
    $0.backgroundColor = .clear
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.contentInsetAdjustmentBehavior = .always
    return $0
  }(UICollectionView(frame: .zero, collectionViewLayout: layout))
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupConstraints()
  }

  func setupViews() {
    view.addSubview(collectionView)
    view.backgroundColor = .lightGray
    collectionView.dataSource = self
    collectionView.register(ChatCell.self, forCellWithReuseIdentifier: ChatCell.identifier)
  }
  
  func setupConstraints() {
    collectionView.snp.makeConstraints {
      $0.top.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
    }
  }
}

// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCell.identifier, for: indexPath) as! ChatCell
    cell.configure(with: messages[indexPath.item])
    return cell
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    messages.count
  }
}


