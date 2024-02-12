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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionViewConfig()
        topView.backButton.isHidden = true
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
        layout.minimumInteritemSpacing = 1.0
        layout.minimumLineSpacing = 1.0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
        return collectionView
    }()
    
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
        clothListCollectionView.register(ListCollectionViewCell.self,
                                forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        clothListCollectionView.delegate = self
        clothListCollectionView.dataSource = self
    }
}

extension ClothListViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width : CGFloat = collectionView.frame.width
        let height : CGFloat = (collectionView.frame.width / 3) - 40.0
        return CGSize(width: width, height: height)
    }
}

extension ClothListViewController : UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ListCollectionViewCell.identifier,
            for: indexPath
        ) as? ListCollectionViewCell else {
            return UICollectionViewCell()
        }
        
//        if topView.selectButton {
//            cell.imageSettingButton.isHidden = true
//        }
//        else {
//            cell.imageSettingButton.isHidden = false
//        }
        
        cell.imageTitleLabel.text = "예쁜옷"
 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 10
    }
}
