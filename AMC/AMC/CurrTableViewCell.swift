//
//  CurrTableViewCell.swift
//  AMC
//
//  Created by Ana Dzamelashvili on 2/18/22.
//

import UIKit



struct CurrTableViewCellViewModel {
    let currency: String
    let buyPrice: String
    let sellPrice: String
}

class CurrTableViewCell: UITableViewCell {
    static let identifier = "CurrTableViewCell"
    
    //subview
    
    private let currencyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let buyLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGreen
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private let sellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemRed
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    
    //initializer
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(currencyLabel)
        contentView.addSubview(buyLabel)
        contentView.addSubview(sellLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError()
    }
    //layout
    
    override func layoutSubviews() {
        super.layoutSubviews()
        currencyLabel.sizeToFit()
        buyLabel.sizeToFit()
        sellLabel.sizeToFit()
        
        
        currencyLabel.frame = CGRect(x: 15,
                                     y: 0,
                                     width: contentView.frame.size.width/2,
                                     height: contentView.frame.size.height/2)
        
        buyLabel.frame = CGRect(x: contentView.frame.size.width/2,
                                     y: 0,
                                     width: (contentView.frame.size.width/2)-10,
                                     height: contentView.frame.size.height/2)
        
        sellLabel.frame = CGRect(x: contentView.frame.size.width/2,
                                     y: contentView.frame.size.height/2,
                                     width: (contentView.frame.size.width/2)-10,
                                     height: contentView.frame.size.height/2)
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        currencyLabel.text = nil
//        buyLabel.text = nil
//        sellLabel.text = nil
//    }
    
    
    //configure
    func configure(with viewModel: CurrTableViewCellViewModel) {
        currencyLabel.text = viewModel.currency
        buyLabel.text = viewModel.buyPrice
        sellLabel.text = viewModel.sellPrice
        
        
    }
    
    
    
}
