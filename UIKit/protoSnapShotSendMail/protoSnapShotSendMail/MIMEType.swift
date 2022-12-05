//
//  MIMEType.swift
//  protoSnapShotSendMail
//
//  Created by Trixie Lulamoon on 2022/8/25.
//

/**
 MINE 為多用途網際網路郵件擴展（Multipurpose Internet Mail Extensions.）的縮寫，MINE是一種網際網路標準，用來定義透過 email 傳送某種資訊（例如，圖形）的方式。MIME 型態指示所要附加檔案的資料型態。舉例來說，PNG圖片的 MINE型態為 image/png。你可以至 http://www.iana.org/assignments/media-types/ 了解完整的 MINE型態。
 */

import Foundation

enum MIMEType: String {
    case jpg = "image/jpeg"
    case png = "image/png"
    case doc = "application/msword"
    case ppt = "application/vnd.ms-powerpoint"
    case html = "text/html"
    case pdf = "application/pdf"
      
    init?(type: String) {
        switch type.lowercased() {
        case "jpg": self = .jpg
        case "png": self = .png
        case "doc": self = .doc
        case "ppt": self = .ppt
        case "html": self = .html
        case "pdf": self = .pdf
        default: return nil
        }
    }
}
