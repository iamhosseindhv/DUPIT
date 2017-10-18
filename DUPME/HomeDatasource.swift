//
//  HomeDatasource.swift
//  DUPME
//
//  Created by Hossein on 28/03/2017.
//  Copyright © 2017 Dupify. All rights reserved.
//

import LBTAComponents

class HomeDatasource: Datasource {
    
    var orders = [Order]()
    
    
    override func footerClasses() -> [AnyClass]? {
        return [UserFooter.self]
    }
    
    override func headerClasses() -> [AnyClass]? {
        return [UserHeader.self]
    }
    
    override func cellClasses() -> [DatasourceCell.Type] {
        return [UserCell.self]
    }
    
    override func item(_ indexPath: IndexPath) -> Any? {
        return orders[indexPath.item]
    }
    
    override func numberOfItems(_ section: Int) -> Int {
        return orders.count
    }
    
}


