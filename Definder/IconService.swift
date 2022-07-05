//
//  IconService.swift
//  Definder
//
//  Created by Pavel Yakimenko on 30/06/2022.
//

import SwiftUI

class IconService {

    static let `default`: IconService = IconService()
    
    let knownFileTypes: [FileAttributeType: Image] = [.typeDirectory: Image(systemName: "folder"),
                                                      .typeRegular: Image(systemName: "doc"),
                                                      .typeSymbolicLink: Image(systemName: "arrow.uturn.right"),
                                                      .typeUnknown: Image(systemName: "questionmark.square.dashed"),
    ]

    func icon(_ fileType: FileAttributeType?) -> Image {
        knownFileTypes[fileType ?? .typeUnknown]!
    }
}
