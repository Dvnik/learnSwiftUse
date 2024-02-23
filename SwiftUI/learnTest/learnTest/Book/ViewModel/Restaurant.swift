//
//  Restaurant.swift
//  learnTest
//
//  Created by 翊軒 on 2024/2/15.
//

import Foundation

struct Restaurant: Identifiable {
    //因為SwiftUI簡化了很多UI的佈局，所以像List要抓出特訂的項目就需要特定的方式去辨別個體位置，UUID就是一個普遍的方法
    var id = UUID()
    
    var name: String
    var image: String
}
