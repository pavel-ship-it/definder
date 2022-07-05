//
//  VolumesListView.swift
//  Definder
//
//  Copyright © 2022 Pavel Yakimenko. All rights reserved.
//

import SwiftUI

struct VolumesListView: View {

    let fileManage = FileManager.default

    var body: some View {
        Text("Vols")
    }

    func getVolumesList() {
        let filemanager = NSFileManager()
        let keys = [NSURLVolumeNameKey, NSURLVolumeIsRemovableKey, NSURLVolumeIsEjectableKey]
        let paths = filemanager.mountedVolumeURLsIncludingResourceValuesForKeys(keys, options: nil)
        if let urls = paths as? [NSURL] {
            for url in urls {
                println(url)
            }
        }
    }
}
