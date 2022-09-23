//
//  ServerListViewController.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import RxGesture

// MARK: ServerListViewController
/*
 ViewController for presenting list of servers
 with filter and logout buttons
 */
final class ServerListViewController: BaseViewController<ServerListViewModel> {
    fileprivate let disposeBag = DisposeBag()
    
    var tableView: UITableView!
    var dataSource: RxTableViewSectionedReloadDataSource<ServerListViewModel.SectionDataModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func bindViewModel() {
        super.bindViewModel()
        
        // configure Table view with cells based on dataModel
        dataSource = RxTableViewSectionedReloadDataSource<ServerListViewModel.SectionDataModel>(
            configureCell: { _, _, _, model in
                switch model {
                case let .item(serverItemModel):
                    let cell = ServerListItemTableViewCell()
                    cell.setupWith(model: serverItemModel)
                    return cell
                }
            }
        )
        
        tableView.rx.setDelegate(self)
            .disposed(by: disposeBag)
        
        // handle Rx tap event on `navigationItem.leftBarButtonItem`
        // and bind to viewModel
        navigationItem.leftBarButtonItem?.customView?.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(to: viewModel.input.presentFilterModalViewObserver)
            .disposed(by: disposeBag)
        
        // handle Rx tap event on `navigationItem.rightBarButtonItem`
        // and bind to viewModel
        navigationItem.rightBarButtonItem?.customView?.rx.tapGesture()
            .when(.recognized)
            .map { _ in }
            .bind(to: viewModel.input.logoutObserver)
            .disposed(by: disposeBag)
        
        viewModel.input.dataModelsDriver
            .drive(tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        navigationItem.title = "Testio."
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            customView: setupNavigationButton(title: HardcodedStrings.filter, iconName: "arrow.up.arrow.down")
        )
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            customView: setupNavigationButton(
                title: HardcodedStrings.logout, iconName: "rectangle.portrait.and.arrow.right", reversed: true
            )
        )
        
        tableView = UITableView(frame: CGRect.zero)
        tableView.register(
            ServerListItemTableViewCell.self,
            forCellReuseIdentifier: ServerListItemTableViewCell.cellIdentifier
        )
        tableView.estimatedRowHeight = UITableView.automaticDimension
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedSectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionHeaderHeight = UITableView.automaticDimension
        tableView.sectionHeaderTopPadding = 0
        tableView.backgroundColor = UIColor.systemGray6
        tableView.addAndAnchorTo(view)
    }
    
    /// Creates Custom Button for Navigation bar
    /// - parameters:
    ///     - title: title of the button
    ///     - iconName: icon next to button
    ///     - reversed: position icon and title
    /// - returns: custom button inside UIStackView
    private func setupNavigationButton(title: String, iconName: String, reversed: Bool = false) -> UIStackView {
        let label = UILabel()
        label.text = title
        label.textColor = UIColor.systemBlue
        
        let imageView = UIImageView(image: UIImage(systemName: iconName))
        imageView.tintColor = UIColor.systemBlue

        let stackView = UIStackView()
        stackView.setup {
            $0.axis = .horizontal
            $0.distribution = .fill
            $0.alignment = .fill
            $0.spacing = 10
        }.setArrangedSubviews(reversed ? [label, imageView] : [imageView, label])
        
        return stackView
    }
}

extension ServerListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return buildTableHeader()
    }
    
    /// Builds Custom Header for the Table Header Section
    private func buildTableHeader() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor.systemGray6
        let stackView = UIStackView()
        stackView.setup {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
        }
        .setArrangedSubviews([
            UILabel().setup {
                $0.font = .systemFont(ofSize: 12, weight: .regular)
                $0.textColor = .systemGray
                $0.text = HardcodedStrings.server.uppercased()
            },
            UILabel().setup {
                $0.font = .systemFont(ofSize: 12, weight: .regular)
                $0.textColor = .systemGray
                $0.text = HardcodedStrings.distance.uppercased()
                $0.textAlignment = .right
            }
        ])
        
        stackView.addAndAnchorTo(
            view,
            insets: UIEdgeInsets(top: 24, left: 16, bottom: 8, right: 16),
            ignoreSafeArea: false
        )
        
        return view
    }
}
