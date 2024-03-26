//
//  ClothList.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/17/24.
//

import UIKit
import SnapKit

protocol ClothListViewControllerDelegate : AnyObject {
    func presentListVC()
    func backToPreviousVC()
    func presentRegisterVC()
}

final class ClothListViewController : BaseViewController {
    weak var delegate : ClothListViewControllerDelegate?
    
    private let clothListManager = ClothListManager.shared
    
    // 상단 이미지 선택 button 클릭 유무 확인하기 위한 toggle
    private var selectToggle = true
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ClothListModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topView.backButton.isHidden = true
        self.setupDataSource()
        self.performQuery()
        self.tabTopViewButtons()
        
        Task {
            do {
                try await ClothesAPI.fetchAllClothes(memberId: "fashionPP").performRequest()
                
                DispatchQueue.main.async {
                    self.performQuery()
                }
                
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    // MARK: - UICollectionView config (+ DiffableDataSource)
    private lazy var clothListCollectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.allowsMultipleSelectionDuringEditing = true
        collectionView.delegate = self

    
        return collectionView
    }()
    
    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<ListCollectionViewCell, ClothListModel> {
            (cell, indexPath, list) in
            var clothList : ClothListModel?
            clothList = self.clothListManager.clothList[indexPath.row]
           
            cell.cloth = clothList
            cell.accessories = [.multiselect()]
        }
        
        self.dataSource = UICollectionViewDiffableDataSource<Section, ClothListModel>(collectionView: self.clothListCollectionView) {
            (collectionView, indexPath, list) -> UICollectionViewListCell? in
            return self.clothListCollectionView.dequeueConfiguredReusableCell(using: cellRegistration, 
                                                                              for: indexPath,
                                                                              item: list)
        }
    }
    
    private func performQuery() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ClothListModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(clothListManager.clothList)
        self.dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: - button click method
    /// topView 내부 select 버튼 클릭에 따라 collectionView 의 선택버튼이 나타남
    private func tabTopViewButtons(){
        topView.selectButton.addAction(UIAction{ _ in
            if self.selectToggle {
                self.clothListCollectionView.isEditing = true
                self.topView.selectButton.tintColor = .lightGray
                self.selectToggle = false
            }
            
            else {
                if self.clothListCollectionView.indexPathsForSelectedItems?.count ?? 0 > 0 {
                    self.delegate?.presentRegisterVC()
                }
                
                else{
                    self.clothListCollectionView.isEditing = false
                    self.topView.selectButton.tintColor = .black
                    self.selectToggle = true
                }
            }
        }, for: .touchUpInside)
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
