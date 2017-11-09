//
//  DouBanAPIManager.swift
//  DouBanList
//
//  Created by E人一铺 on 2017/11/9.
//  Copyright © 2017年 E人一铺. All rights reserved.
//

import Foundation
import Moya

// 初始化网络请求的provider，即请求发起对象
// 接着声明一个enum,对请求进行明确分类
// 最后让enum实现TargetType协议，在这里定义各个请求的URL，参数，header等信息

// 初始化provider
let DouBanProvider = MoyaProvider<DouBan>()


// 请求分类
public enum DouBan {
    
    case channels // 获取频道列表
    case playList(String) // 获取歌曲
    
}

// 请求配置
extension DouBan: TargetType {
    
    public var baseURL: URL {
        switch self {
        case .channels:
            return URL.init(string: "https://www.douban.com")!
        case .playList(_):
            return URL(string: "https://douban.fm")!
        }
    }
    
    public var path: String {
        switch self {
        case .channels:
            return "/j/app/radio/channels"
        case .playList(_):
            return "/j/mine/playlist"
        }
    }
    
    public var method: Moya.Method {
        return .get
    }
    
    // 做单元测试使用的模拟数据
    public var sampleData: Data {
        return "{}".data(using: String.Encoding.utf8)!
    }
    
    // 请求任务事件（在这里产参数）
    public var task: Task {
        switch self {
        case .playList(let channel):
            var params: [String : Any] = [:]
            params["channel"] = channel
            params["type"]    = "n"
            params["from"] = "mainsite"
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    // 请求头
    public var headers: [String : String]? {
        return nil
    }
    
    //是否执行Alamofire验证
    public var validate: Bool {
        return false
    }
    
    
}
