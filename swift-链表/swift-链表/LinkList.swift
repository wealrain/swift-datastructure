//
//  LinkList.swift
//  swift-单向链表
//
//  Created by zhoutaosheng on 16/4/19.
//  Copyright © 2016年 etc. All rights reserved.
//

import Foundation

enum LinkListError : ErrorType {
    case IndexOutOfBoundsError
    case LinkListIsEmptyError
}


/*
 * 定义节点类型
 */
private class Node<T>{
    var data:T
    var next:Node?
    
    init(data:T){
        self.data = data;
        self.next = nil
    }
}
/*
 * 定义链表类型
 */
class LinkList<T> {
    
    private var head:Node<T>?
    init(){
        head = nil
    }
    
    /*
     *链表的插入
     *   1、考虑表头是否为空
     *   2、考虑插入的位置为表头位置
     *   3、无法直接获取要插入的位置，从头开始遍历，
     *       直到所在位置
     *
     */
    func insert(data:T,index:Int) throws{
        let node = Node(data:data)
        if head == nil  {
            if index != 0 {
                throw LinkListError.LinkListIsEmptyError
            } else {
                head = node
            }
            return
        }
        
        if index == 0 {
            node.next = head
            head = node
            return
        }
        var current_node:Node = head!
        var count = 0
        while (current_node.next != nil) && (count < index - 1) {
            current_node = current_node.next!
            count += 1
        }
        //防止index超出链表已有长度
        if count == index - 1 {
            //考虑是否插入到最后一个位置
            if current_node.next != nil {
                node.next = current_node.next!
            }
            current_node.next = node
        }else {
            throw LinkListError.IndexOutOfBoundsError
        }
        
    }
    
    /*
     * 遍历输出
     */
    func output(){
        if head == nil {
            print("[]")
        }
        
        var current_node:Node? = head
        while current_node != nil {
            print(current_node?.data,terminator:" ")
            current_node = current_node?.next
        }
        print()
    }
    
    /*
     * 删除节点
     *   1、考虑链表是否为空
     *   2、考虑是否删除表头
     *
     */
    func delete(index:Int){
        if head == nil {
            return
        }
        if index == 0 {
            head = head?.next
        }
        var current_node:Node? = head
        var count = 0
        
        while(current_node?.next != nil) && (count<index - 1) {
            current_node = current_node?.next
            count += 1
        }
        if count == index - 1 && current_node?.next != nil{
            let delete_node:Node! = current_node?.next
            current_node?.next = delete_node.next
        }
    
        
    }
    /*
     * 链表元素的获取
     *
     */
    func get(index:Int) throws -> T {
        var _index = index
        //链表为空
        if head == nil {
            throw LinkListError.LinkListIsEmptyError
        }
        var current_node = head
        
        while _index > 0 && current_node?.next != nil {
            current_node = current_node?.next
            _index -= 1
        }
        if _index == 0 {
            return (current_node?.data)!
        }else {
            throw LinkListError.IndexOutOfBoundsError
        }
    }
    
    /*
     * 链表的添加
     *  在最后添加一个节点
     */
    func append(data:T){
        let node = Node(data:data)
        if head == nil {
            head = node
            return
        }
        var current_node = head
        while current_node?.next != nil {
            current_node = current_node?.next
        }
        current_node?.next = node
    }
    
    /*
     * 链表的反转
     *    1、考虑链表为空
     *    2、考虑链表只有一个节点
     */
    func reverse(){
        if head == nil || head?.next == nil {
            return
        }
        
        var current_node,next_node:Node<T>?
        current_node = head?.next
        head?.next = nil
        while current_node != nil {
            next_node = current_node?.next
            current_node?.next = head
            head = current_node
            current_node = next_node
            
        }
    }
}
