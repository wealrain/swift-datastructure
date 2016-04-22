//
//  SingleCircleLinkList.swift
//  Test
//
//  Created by zts on 16/4/21.
//  Copyright © 2016年 zts. All rights reserved.
//

import Cocoa


private class Node<T>{
    var data:T
    var next:Node<T>?
    
    init(data:T){
        self.data = data
    }
}

class SingleCircleLinkList<T>{
    
    private var tail:Node<T>?//永远指向最后一个节点
    
    func append(data:T){
        let node = Node(data:data)
        //考虑链表为空
        if tail == nil {
            tail = node
            node.next = tail
            return
        }
        node.next = tail?.next
        tail?.next = node
        tail = node
    }
    
    func output(){
        //考虑链表为空
        if tail == nil {
            print("[]")
        }
        var current_node = tail?.next
        //循环输出数据，一直到尾节点，但不包含尾节点
        while current_node !== tail {
            print(current_node?.data,terminator:" ")
            current_node = current_node?.next
        }
        //输出尾节点数据
        print(tail?.data)
    }
    
    func insert(data:T,index:Int) throws{
        let node = Node(data: data)
        //链表为空
        if tail == nil {
            if index == 0 {
                tail = node
                tail?.next = tail
                return
            }else {
                throw LinkListError.IndexOutOfBoundsError
            }
        }
        //插在表头
        if index == 0 {
            node.next = tail?.next
            tail?.next = node
            return
        }
        var current_node = tail?.next
        var count = 0
        
        //不能在尾部节点后插入数据
        while current_node?.next !== tail && count < index - 1 {
            current_node = current_node?.next
            count += 1
        }
        if count == index - 1 {
            node.next = current_node?.next
            current_node?.next = node
        }else {
            throw LinkListError.IndexOutOfBoundsError
        }
    }
    
    func delete(index:Int) throws{
        if tail == nil {
            throw LinkListError.IndexOutOfBoundsError
        }
        
        if index == 0 {
            tail?.next = tail?.next?.next
            return
        }
        
        var current_node = tail?.next
        var count = 0
        
        while current_node?.next !== tail && count < index - 1{
            current_node = current_node?.next
            count+=1
        }
        
        if count == index - 1 {
            let next = current_node?.next
            current_node?.next = next?.next
            //判断是否是最后一个
            if next === tail {
                tail = current_node
            }
            next?.next = nil
            
        }else {
            throw LinkListError.IndexOutOfBoundsError
        }
    }
    
    func get(index:Int) throws -> T{
        if tail == nil {
            throw LinkListError.IndexOutOfBoundsError
        }
        
        var current_node = tail?.next
        
        if index == 0 {
            return (current_node?.data)!
        }
        var count = 0
        while current_node?.next !== tail && count < index - 1 {
            current_node = current_node?.next
            count+=1
        }
        if count == index - 1 {
            return (current_node?.next?.data)!
        }else {
            throw LinkListError.IndexOutOfBoundsError
        }
    }
    
    func reverse(){
        if tail == nil {
            return
        }
        var current_node = tail?.next
        var head = current_node
        var next = current_node?.next
        //让原来的表头成为表尾
        tail = head
        while next !== tail {
            current_node = next
            next = next?.next
            current_node?.next = head
            head = current_node
        }
        tail?.next = head
    }
}
