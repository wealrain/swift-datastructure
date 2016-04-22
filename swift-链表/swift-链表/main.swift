//
//  main.swift
//  swift-顺序表
//
//  Created by zhoutaosheng on 16/4/19.
//  Copyright © 2016年 etc. All rights reserved.
//

import Foundation

print("Hello, World!")
//Linklist测试
var linklist = LinkList<Int>()
linklist.append(1)
linklist.append(2)
linklist.append(3)
try linklist.insert(5, index: 2)
linklist.output()
//SingleCircleLinkList测试
var sclinklist = SingleCircleLinkList<Int>()
sclinklist.append(1)
sclinklist.append(2)
try sclinklist.insert(3,index:0)
sclinklist.reverse()
sclinklist.output()
