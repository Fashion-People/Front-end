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
    func backToPreviousVC()
    func presentRegisterVC()
}

final class ClothListViewController : BaseViewController {
    weak var coordinator : ListNavigation?
    
    private var selectToggle = true
    private let clothLists : [ListModel] = [ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://"),ListModel(clothDescription: "예쁜옷", clothImageURL: "https://")]
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ListModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topView.backButton.isHidden = true
        self.setupDataSource()
        self.performQuery()
        self.topView.selectButton.addTarget(self, action: #selector(tapTopCheckButton), for: .touchUpInside)
    }
    
    init(coordinator: ListNavigation) {
        self.coordinator = coordinator
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var clothListCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelectionDuringEditing = true
        collectionView.delegate = self

    
        return collectionView
    }()
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ListCollectionViewCell, ListModel> {
            (cell, indexPath, list) in
            var clothList : ListModel?
            clothList = self.clothLists[indexPath.row]
           
            cell.cloth = clothList
            cell.accessories = [.multiselect()]
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, ListModel>(collectionView: self.clothListCollectionView) {
            (collectionView, indexPath, list) -> UICollectionViewListCell? in
            return self.clothListCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, 
                                                                              for: indexPath,
                                                                              item: list)
        }
    }
    
    func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ListModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(clothLists)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc private func tapTopCheckButton() {
        if selectToggle {
            clothListCollectionView.isEditing = true
            topView.selectButton.tintColor = .lightGray
            selectToggle = false
        }
        
        else {
            if clothListCollectionView.indexPathsForSelectedItems?.count ?? 0 > 0 {
                self.coordinator?.presentRegisterVC()
            }
            
            else{
                clothListCollectionView.isEditing = false
                topView.selectButton.tintColor = .black
                selectToggle = true
            }
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
}

extension ClothListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width : CGFloat = collectionView.bounds.width
        return CGSize(width: width, height: width/4)
    }
}
