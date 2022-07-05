//
//  ViewController.swift
//  Telega
//
//  Created by Vladimir Fibe on 27.06.2022.
//

import UIKit
import SnapKit

protocol SelfConfiguringMessage {
  static var reuseIdentifier: String { get }
  func configure(with reaction: Reaction)
}

struct ElementKind {
    static let badge = "badge-element-kind"
    static let background = "background-element-kind"
    static let sectionHeader = "section-header-element-kind"
    static let sectionFooter = "section-footer-element-kind"
    static let layoutHeader = "layout-header-element-kind"
    static let layoutFooter = "layout-footer-element-kind"
}

class ViewController: UIViewController {
  var messages = Message.all
  var collectionView: UICollectionView! = nil
  var dataSourse: UICollectionViewDiffableDataSource<Message, Reaction>! = nil
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureHierarchy()
    configureDataSource()
  }
  
  func configure<T: SelfConfiguringMessage>(_ cellType: T.Type, with reaction: Reaction, for indexPath: IndexPath) -> T {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellType.reuseIdentifier, for: indexPath) as? T else { fatalError("Unable to dequeue \(cellType)")}
    cell.configure(with: reaction)
    return cell
  }

  func createMessage(using message: Message) -> NSCollectionLayoutSection {
    let itemSize = NSCollectionLayoutSize(widthDimension: .estimated(90), heightDimension: .estimated(30))
    let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
    layoutItem.edgeSpacing = NSCollectionLayoutEdgeSpacing(leading: .fixed(0), top: .fixed(5), trailing: .fixed(5), bottom: .fixed(0))
    let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(60))
    let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])
    let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
    let layoutSectionHeader = createMessageHeader()
    let layoutSectionFooter = createMessageFooter()
    let sectionBackground = NSCollectionLayoutDecorationItem.background(elementKind: ElementKind.background)
    layoutSection.decorationItems = [sectionBackground]
    layoutSection.boundarySupplementaryItems = [layoutSectionHeader, layoutSectionFooter]
    layoutSection.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 20, bottom: 20, trailing: 0)
    return layoutSection
  }
  func createCompositionalLayout() -> UICollectionViewLayout {
    let layout = UICollectionViewCompositionalLayout { messageIndex, layoutEnvironment in
      let message = self.messages[messageIndex]
      return self.createMessage(using: message)
    }
    let config = UICollectionViewCompositionalLayoutConfiguration()
    config.interSectionSpacing = 0
    layout.configuration = config
    layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: ElementKind.background)
    return layout
  }
  func createMessageHeader() -> NSCollectionLayoutBoundarySupplementaryItem {
    let layoutMessageHeaderSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(10))
    let layoutMessageHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutMessageHeaderSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .topLeading)
    return layoutMessageHeader
  }
  func createMessageFooter() -> NSCollectionLayoutBoundarySupplementaryItem {
    let layoutMessageFooterSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(10))
    let layoutMessageFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: layoutMessageFooterSize, elementKind: UICollectionView.elementKindSectionFooter, alignment: .bottomTrailing)
    return layoutMessageFooter
  }
}
extension ViewController {
  func createLayout() -> UICollectionViewLayout {
    let itemSize = NSCollectionLayoutSize(
      widthDimension: .estimated(90),
      heightDimension: .estimated(30))
    let item = NSCollectionLayoutItem(layoutSize: itemSize)
    item.edgeSpacing = NSCollectionLayoutEdgeSpacing(
      leading: .fixed(0), top: .fixed(5),
      trailing: .fixed(5), bottom: .fixed(0))
    
    let groupSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1),
      heightDimension: .estimated(60))
    let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
    
    let section = NSCollectionLayoutSection(group: group)
    section.interGroupSpacing = 5
    section.contentInsets = NSDirectionalEdgeInsets(
      top: 0, leading: 20, bottom: 20, trailing: 0)
    
    let headerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
    let footerSize = NSCollectionLayoutSize(
      widthDimension: .fractionalWidth(1), heightDimension: .estimated(30))
    let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: ElementKind.sectionHeader, alignment: .top)
    let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: footerSize, elementKind: ElementKind.sectionFooter, alignment: .bottom)
    
    let sectionBackgroundDecoration = NSCollectionLayoutDecorationItem.background(
      elementKind: ElementKind.background)
    sectionBackgroundDecoration.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
    section.decorationItems = [sectionBackgroundDecoration]

    section.boundarySupplementaryItems = [sectionHeader, sectionFooter]
    let layout = UICollectionViewCompositionalLayout(section: section)
    layout.register(SectionBackgroundDecorationView.self, forDecorationViewOfKind: ElementKind.background)
    return layout
  }
}
extension ViewController {
  func configureHierarchy() {
    collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
    collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    collectionView.backgroundColor = .systemBackground
    view.addSubview(collectionView)
  }
  func configureDataSource() {
    let cellRegistration = UICollectionView.CellRegistration<MessageCell, Reaction> { cell, indexPath, reaction in
      cell.configure(with: reaction)
    }
    
    let headerRegistration = UICollectionView.SupplementaryRegistration<MessageFooterView>(elementKind: ElementKind.sectionHeader) { supplementaryView, string, indexPath in
      supplementaryView.timeLabel.text = "Заговолок"
    }

    let footerRegistration = UICollectionView.SupplementaryRegistration<MessageFooterView>(elementKind: ElementKind.sectionFooter) { supplementaryView, string, indexPath in
      supplementaryView.timeLabel.text = "20:00"
    }
    
    dataSourse = UICollectionViewDiffableDataSource<Message, Reaction>(collectionView: collectionView) { collectionView, indexPath, reaction in
      collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: reaction)
    }
    
    dataSourse.supplementaryViewProvider = {view, kind, index in
      self.collectionView.dequeueConfiguredReusableSupplementary(using: kind == ElementKind.sectionHeader ? headerRegistration : footerRegistration, for: index)
    }
    reloadData()
  }
  func reloadData() {
    var snapshot = NSDiffableDataSourceSnapshot<Message, Reaction>()
    snapshot.appendSections(messages)
    for message in messages {
      snapshot.appendItems(message.reactions, toSection: message)
    }
    dataSourse.apply(snapshot)
  }
}
