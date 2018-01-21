//
//  SectionOfRepositoriesModel.swift
//  GithubViewer
//
//  Created by Haythem BEN AICHA on 1/21/18.
//  Copyright © 2018 Haythem BEN AICHA. All rights reserved.
//

import Foundation
import RxDataSources

struct SectionOfRepositoriesModel {
    var header: String
    var items: [Item]
}
extension SectionOfRepositoriesModel: SectionModelType {
    typealias Item = RepositoryModel
    
    init(original: SectionOfRepositoriesModel, items: [Item]) {
        self = original
        self.items = items
    }
}
