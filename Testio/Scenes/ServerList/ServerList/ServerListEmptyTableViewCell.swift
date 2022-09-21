//
//  ServerListEmptyTableViewCell.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import UIKit

class ServerListEmptyTableViewCell: UITableViewCell {
    static let cellIdentifier = "serverListEmptyCell"
    
    private lazy var serverLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.text = HardcodedStrings.server.uppercased()
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = .systemGray
        label.text = HardcodedStrings.distance.uppercased()
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupUI()
    }
    
    func setupUI() {
        contentView.backgroundColor = UIColor.systemGray6
        contentView.removeSubviews()

        var stackView: UIStackView!
        UIStackView().setup {
            $0.axis = .horizontal
            $0.alignment = .fill
            $0.distribution = .equalSpacing
            stackView = $0
        }
        .setArrangedSubviews([
            serverLabel,
            distanceLabel
        ])
        
        contentView.addSubview(stackView)
        stackView.anchorToSuperview(
            insets: UIEdgeInsets(
                top: 24, left: 16, bottom: 8, right: 16
            )
        )
    }
}
