//
//  ServiceListViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources

final class ServerListViewController: BaseViewController<ServerListViewModel> {
    fileprivate let disposeBag = DisposeBag()
    
    var navigationRightItemView: UIButton!
    var navigationLeftItemView: UIButton!
    var tableView: UITableView!
    var dataSource: RxTableViewSectionedReloadDataSource<ServerListViewModel.SectionDataModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        dataSource = RxTableViewSectionedReloadDataSource<ServerListViewModel.SectionDataModel>(
            configureCell: { _, _, _, model in
                switch model {
                case .empty:
                    let cell = ServerListEmptyTableViewCell()
                    return cell
                    
                case let .item(serverItemModel):
                    let cell = ServerListItemTableViewCell()
                    cell.setupWith(model: serverItemModel)
                    return cell
                }
            }
        )
        
        viewModel.input.dataModelsDriver
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        viewModel.input.startObserver.onNext(())
    }
    
    override func setupUI() {
        navigationItem.title = "Testio."
        
        navigationRightItemView = setupNavigationRightButton()
        navigationLeftItemView = setupNavigationRightButton()
        navigationItem.rightBarButtonItem = UIBarButtonItem(systemItem: .play)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: navigationLeftItemView)
        // Do any additional setup after loading the view.
        
        tableView = UITableView(frame: CGRect.zero)
        tableView.register(
            ServerListEmptyTableViewCell.self,
            forCellReuseIdentifier: ServerListEmptyTableViewCell.cellIdentifier
        )
        tableView.register(
            ServerListItemTableViewCell.self,
            forCellReuseIdentifier: ServerListItemTableViewCell.cellIdentifier
        )
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionFooterHeight = CGFloat.leastNormalMagnitude
        tableView.backgroundColor = UIColor.systemGray6
        tableView.addAndAnchorTo(view)
    }
    
    private func setupNavigationRightButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "rectangle.portrait.and.arrow.right"), for: .normal)
        
        return button
    }
}

extension ServerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
