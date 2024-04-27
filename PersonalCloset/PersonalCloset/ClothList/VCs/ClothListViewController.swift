//
//  ClothList.swift
//  PersonalCloset
//
//  Created by Bowon Han on 1/17/24.
//

import UIKit
import SnapKit

protocol ClothListViewControllerDelegate: AnyObject {
    func presentListVC()
    func backToPreviousVC()
    func presentRegisterVC()
}

final class ClothListViewController: BaseViewController {
    weak var delegate: ClothListViewControllerDelegate?
    
    private enum Metric {
        static let top: CGFloat = 10
    }
    
    private let clothListManager = ClothListManager.shared
    
    /// 상단 이미지 선택 button 클릭 유무 확인하기 위한 toggle
    private var selectToggle = true
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ClothListModel>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.topView.backButton.isHidden = true
        self.setupDataSource()
        self.tabTopViewButtons()
        
        Task {
            do {
                /// Fetch a list of all clothes from the server
                try await ClothesAPI.fetchAllClothes.performRequest()
                
                DispatchQueue.main.async {
                    self.performQuery()
                }
                
            } catch { print("error: \(error)") }
        }
    }
    
    // MARK: - UICollectionView config (+ DiffableDataSource)
    private lazy var clothListCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        collectionView.allowsMultipleSelectionDuringEditing = true
        collectionView.delegate = self
    
        return collectionView
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                              heightDimension: .absolute(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .absolute(100))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }

    private func setupDataSource() {
        let cellRegistration = UICollectionView.CellRegistration<
                                                ListCollectionViewCell,
                                                ClothListModel> {
                                                    (cell, indexPath, list) in
                                                    cell.cloth = list
                                                    cell.accessories = [ .multiselect() ]
                                                    
                                                    cell.deleteAction = { [unowned self] in
                                                        self.deleteList(listNumber: list.clothesNumber)
                                                    }
                                                    
                                                    cell.modifyAction = { [unowned self] in
                                                        self.modifyList(listNumber: list.clothesNumber)
                                                    }
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
    
    /// deleteList method
    // 삭제하려는 cell이 삭제되지 않는 버그
    private func deleteList(listNumber: Int) {
        Task {
            do {
                try await ClothesAPI.deleteCloth(clothId: listNumber).performRequest()
                try await ClothesAPI.fetchAllClothes.performRequest()
                
                DispatchQueue.main.async {
                    self.performQuery()
                }
            } catch {
                print("error: \(error)")
            }
        }
    }
    
    /// modifyList method
    private func modifyList(listNumber: Int) {
        let modifyAlert = UIAlertController(title: "변경", message: "변경 내용을 작성해주세요", preferredStyle: UIAlertController.Style.alert)
        modifyAlert.addTextField()
        
        let success = UIAlertAction(title: "확인", style: .default) { action in
            var param = ModifyRequestDTO(description: "")
            param.description = modifyAlert.textFields?[0].text ?? ""
            print(param.description)
            
            Task {
                do {
                    try await ClothesAPI.modifyCloth(clothId: listNumber).performRequest(with: param)
                    try await ClothesAPI.fetchAllClothes.performRequest()
                    
                    DispatchQueue.main.async {
                        self.performQuery()
                    }
                } catch {
                    print("error: \(error)")
                }
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel) { action in
            
        }
        
        modifyAlert.addAction(success)
        modifyAlert.addAction(cancel)
        
        self.present(modifyAlert, animated: true, completion: nil)
    }


    // MARK: - button click method
    /// topView 내부 select 버튼 클릭에 따라 collectionView 의 선택버튼이 나타남
    private func tabTopViewButtons() {
        topView.selectButton.addAction(UIAction { _ in
            
            /// Selecting a list of clothes to inspect
            if self.selectToggle {
                self.clothListCollectionView.isEditing = true
                self.topView.selectButton.tintColor = .black
                self.selectToggle = false
            }
            
            else {
                if self.clothListCollectionView.indexPathsForSelectedItems?.count ?? 0 > 0 {
                    self.delegate?.presentRegisterVC()
                }
                
                /// If nothing is selected, nothing happens
                else {
                    self.clothListCollectionView.isEditing = false
                    self.topView.selectButton.tintColor = .lightGray
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
            $0.top.equalTo(topView.snp.bottom).offset(Metric.top)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension ClothListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width: CGFloat = collectionView.bounds.width
        return CGSize(width: width, height: width/4)
    }
}
