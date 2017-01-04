//
//  QTHomeModel.swift
//  bantang
//
//  Created by chenqitao on 2017/1/3.
//  Copyright © 2017年 陈齐涛. All rights reserved.
//

import UIKit
import SwiftyJSON
class QTHomeModel: NSObject {
    var trace_id = String()
    var hide_new = Bool()
    var title = String()
    var praises = String()
    var likes = String()
    var items = String()
    var type_id = String()
    var views = String()
    var type = String()
    var id = String()
    var user = QTHomeUserModel()
    var pic = String()
    var is_recommend = Bool()
    var dateline = String()
    var datestr = String()
    var pics = Array<Any>()
    var islike = Bool()
    var comments = String()
    var update_time = String()
    var is_show_like = String()
    var create_time_str = String()
    class func initWithJson(json:JSON) -> QTHomeModel {
        let homeModel = QTHomeModel()
        homeModel.trace_id = json["trace_id"].stringValue
        homeModel.hide_new = json["hide_new"].boolValue
        homeModel.title = json["title"].stringValue
        homeModel.praises = json["praises"].stringValue
        homeModel.likes = json["likes"].stringValue
        homeModel.items = json["items"].stringValue
        homeModel.type_id = json["type_id"].stringValue
        homeModel.views = json["views"].stringValue
        homeModel.type = json["type"].stringValue
        homeModel.id = json["id"].stringValue
        homeModel.pic = json["pic"].stringValue
        homeModel.is_recommend = json["is_recommend"].boolValue
        homeModel.dateline = json["dateline"].stringValue
        homeModel.datestr = json["datestr"].stringValue
        homeModel.pics = json["pics"].arrayObject!
        homeModel.islike = json["islike"].boolValue
        homeModel.comments = json["comments"].stringValue
        homeModel.update_time = json["update_time"].stringValue
        homeModel.is_show_like = json["is_show_like"].stringValue
        homeModel.create_time_str = json["create_time_str"].stringValue
        homeModel.user.article_topic_count = json["user"]["article_topic_count"].stringValue
        homeModel.user.post_count = json["user"]["post_count"].stringValue
        homeModel.user.user_id = json["user"]["user_id"].stringValue
        homeModel.user.nickname = json["user"]["nickname"].stringValue
        homeModel.user.is_official = json["user"]["is_official"].stringValue
        homeModel.user.avatar = json["user"]["avatar"].stringValue
        return homeModel
    }
}

class QTHomeUserModel: NSObject {
    var article_topic_count = String()
    var post_count = String()
    var user_id = String()
    var nickname = String()
    var is_official = String()
    var avatar = String()
}
