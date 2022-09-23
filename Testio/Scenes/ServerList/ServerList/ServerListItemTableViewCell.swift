//
//  ServerListItemTableViewCell.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import UIKit

// MARK: ServerListItemTableViewCell
/*
 TableViewCell for presenting server name and server distanse
 */
class ServerListItemTableViewCell: UITableViewCell {
    static let cellIdentifier = "serverListItemCell"
    
    lazy var serverLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .regular)
        label.textColor = .black
        label.textAlignment = .right
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        setupUI()
    }
    
    func setupWith(model: ServerModel) {
        serverLabel.text = model.name
        distanceLabel.text = "\(model.distance) km"
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor.white
        contentView.removeSubviews()
        
        var serverInfoRmationView: UIStackView!
        UIStackView().setup {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .fill
            serverInfoRmationView = $0
        }
        .setArrangedSubviews([
            serverLabel,
            distanceLabel
        ])

        var mainView: UIStackView!
        UIStackView().setup {
            $0.axis = .vertical
            $0.alignment = .fill
            $0.distribution = .fill
            $0.spacing = 12
            mainView = $0
        }
        .setArrangedSubviews([
            serverInfoRmationView,
            UIView.separator()
        ])
        
        contentView.addSubview(mainView)
        mainView.anchorToSuperview(
            insets: UIEdgeInsets(
                top: 12, left: 16, bottom: 0, right: 16
            )
        )
    }
}
