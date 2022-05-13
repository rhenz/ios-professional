//
//  AccountSummaryHeaderView.swift
//  Banco
//
//  Created by John Salvador on 5/13/22.
//

import UIKit

class AccountSummaryHeaderView: UIView {
    // MARK: - IBOutlets
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: UIView.noIntrinsicMetric, height: 144)
    }
    
    // MARK: - Helper Methods
    private func commonInit() {
        let bundle = Bundle(for: AccountSummaryHeaderView.self)
        bundle.loadNibNamed(String(describing: type(of: self)), owner: self)
        addSubview(contentView)
        contentView.backgroundColor = appColor

        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        contentView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        contentView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
}
