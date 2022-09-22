//
//  ServerListItemTableViewCell.swift
//  Testio
//
//  Created by Timur Asayonok on 20/09/2022.
//

import UIKit

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
                top: 12, left: 16, bottom: 12, right: 16
            )
        )
    }
}
