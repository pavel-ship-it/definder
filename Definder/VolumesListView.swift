//
//  VolumesListView.swift
//  Definder
//
//  Copyright © 2022 Pavel Yakimenko. All rights reserved.
//

import SwiftUI

struct VolumesListView: View {

    let fileManager = FileManager.default

    var body: some View {
        Text("Vols")
    }

    func getVolumesList() {
        guard let paths = fileManager.mountedVolumeURLs(includingResourceValuesForKeys: [.volumeNameKey,
                                                                                         .volumeIsRemovableKey,
                                                                                         .volumeIsEjectableKey])
        else {
            print("Volumes not found")
            return
        }
        for url in paths {
            print(url)
        }
    }
}
