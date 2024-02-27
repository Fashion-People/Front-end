//
//  ClothList.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/17/24.
//

import UIKit
import SnapKit

protocol ListNavigation : AnyObject {
    func presentListVC()
    func backToMain()
}

final class ClothListViewController : BaseViewController {
    weak var coordinator : ListNavigation?
    
    private var selectToggle = true
    private let clothList : [ListModel] = [ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://")]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ListModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewConfig()
        topView.backButton.isHidden = true
        setupDataSource()
        performQuery()
        topView.selectButton.addTarget(self, action: #selector(tapTopCheckButton), for: .touchUpInside)
    }
    
    init(coordinator: ListNavigation) {
        self.coordinator = coordinator
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let clothListCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelectionDuringEditing = true
    
        return collectionView
    }()
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListModel> {
            (cell, indexPath, list) in
            var content = cell.defaultContentConfiguration()

            // Configure content.
            content.image = UIImage(systemName: "star")
            content.text = "Favorites"

            cell.contentConfiguration = content
            cell.accessories = [.multiselect()]
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, ListModel>(collectionView: self.clothListCollectionView) {
            (collectionView, indexPath, list) -> UICollectionViewListCell? in
            return self.clothListCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: list)
        }
    }
    
    func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(clothList)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc private func tapTopCheckButton() {
        if selectToggle {
            clothListCollectionView.isEditing = true
            topView.selectButton.tintColor = .gray
            selectToggle = false
        }
        
        else {
            clothListCollectionView.isEditing = false
            topView.selectButton.tintColor = .black
            selectToggle = true
        }
    }
    
    override func setLayout() {
        super.setLayout()
        
        [clothListCollectionView].forEach {
            view.addSubview($0)
        }
        
        clothListCollectionView.snp.makeConstraints {
            $0.top.equalTo(topView.snp.bottom).offset(10)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func collectionViewConfig() {
//  clothListCollectionView.register(ListCollectionViewCell.self,forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        clothListCollectionView.delegate = self
//        clothListCollectionView.dataSource = self
    }
}

extension ClothListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width : CGFloat = collectionView.frame.width
        let height : CGFloat = (collectionView.frame.width / 3) - 50.0
        return CGSize(width: width, height: height)
    }
}

extension ClothListViewController : UICollectionViewDelegate {

}
