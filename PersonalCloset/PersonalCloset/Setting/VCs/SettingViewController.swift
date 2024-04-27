//
//  SettingViewController.swift
//  PersonalCloset
//
//  Created by Bowon Han on 12/30/23.
//

import UIKit

protocol SettingViewControllerDelegate: AnyObject {
    func presentSetting()
}

final class SettingViewController: UIViewController {
    var setting: [String] = ["회원 정보 수정","로그아웃","앱 버전","개인정보 처리방침"]
    var account: [String] = ["회원 탈퇴"]
    
    weak var delegate: SettingViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        self.setupLayouts()
        self.setupConstraints()
    }
    
    private lazy var settingTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .insetGrouped)
        tableView.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.identifier)
        
        return tableView
    }()
    
    // MARK: - UI Layouts config
    private func setupLayouts() {
        view.addSubview(settingTableView)
    }
    
    // MARK: - UI Constraints config
    private func setupConstraints() {
        settingTableView.snp.makeConstraints {
            $0.top.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

// MARK: - extension
extension SettingViewController : UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = settingTableView.dequeueReusableCell(
            withIdentifier: SettingTableViewCell.identifier,
            for: indexPath
        ) as? SettingTableViewCell else {
            return UITableViewCell()
        }
        
        var name : String = ""
        
        switch indexPath.section {
        case 0:
            name = setting[indexPath.row]
        case 1:
            name = account[indexPath.row]
        default:
            return UITableViewCell()
        }
        cell.settingTitleLabel.text = name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var countSectionList = 0
            
        switch section {
        case 0:
            countSectionList = setting.count
        case 1:
            countSectionList = account.count
        default:
            return countSectionList
        }
        return countSectionList
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var countSectionListName = ""
            
        switch section {
        case 0:
            countSectionListName = "Setting"
        case 1:
            countSectionListName = "Account"
        default:
            return countSectionListName
        }
        return countSectionListName
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}
