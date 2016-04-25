//
//  DuCircleLinkList..swift
//  双向循环链表
//
//  Created by zts on 16/4/22.
//  Copyright © 2016年 zts. All rights reserved.
//

import Cocoa
enum LinkListError : ErrorType {
    case IndexOutOfBoundsError
    case LinkListIsEmptyError
}

private class Node<T>{
    var data:T
    var next:Node<T>?
    var prev:Node<T>?
    
    init(data:T){
       self.data = data
    }
}
class DuCircleLinkList<T>: NSObject {
    private var head:Node<T>?
    private var count = 0
    //在后面添加一个节点
    func append(data:T){
        let node = Node(data: data)
        self.count+=1
        //链表为空
        if head == nil {
            head = node
            head?.next = head
            head?.prev = head
            return
        }
        
        let current_node = head?.prev
        current_node?.next = node
        node.prev = current_node
        node.next = head
        head?.prev = node
        
    }
    
    //遍历链表
    func output(){
        if head == nil {
            print("[]")
            return
        }
        var current_node = head
        while current_node?.next !== head  {
            print(current_node?.data)
            current_node = current_node?.next
        }
        print(current_node?.data)
    }
    
    //获取位置节点
    private func getNode(index:Int) throws -> Node<T> {
        if head == nil || index > count-1 || index < 0{
            throw LinkListError.IndexOutOfBoundsError
        }
        
        //如果在前面一半，从前找，否则从后找
        if index <= self.count/2 {
            var current_node = head
            var _count = index
            while _count>0 {
                current_node = current_node?.next
                _count -= 1
            }
            return current_node!
        }
        var _count = self.count - 1
        var current_node = head?.prev
        while _count > index {
            current_node = current_node?.prev
            _count -= 1
        }
        return current_node!
    }
    
    //获取节点数据
    func get(index:Int) throws -> T {
        let node = try self.getNode(index)
        return node.data
    }
    
    //插入数据
    func insert(data:T,index:Int) throws{
        let node = Node(data: data)
        //考虑链表为空
        if head == nil {
            if index != 0 {
                throw LinkListError.IndexOutOfBoundsError
            }
            head = node
            head?.next = node
            head?.prev = node
            self.count += 1
            return
        }
        
        //获取要插入位置的原节点
        let current_node = try getNode(index)
        let before_current_node = current_node.prev
        
        node.next = current_node
        current_node.prev = node
        node.prev = before_current_node
        before_current_node?.next = node
        
        if index == 0 {
            head = node
        }
        self.count += 1
    }
    
    //节点的删除
    func delete(index:Int) throws{
        //获取要删除的链表
        let node = try getNode(index)
        let prev = node.prev
        let next = node.next
        if index == 0 {
            head = next
        }
        prev?.next = next
        next?.prev = prev
        node.next = nil
        node.prev = nil
        self.count -= 1
    }
    

}
