# frozen_string_literal: true

# class for a single node
class Node
  attr_accessor :next_node, :value

  def initialize(value = nil, next_node = nil)
    @next_node = next_node
    @value = value
  end
end

# class for the whole list of nodes
class LinkedList
  attr_reader :head, :tail

  def initialize
    @head = nil
    @tail = nil
  end

  def append(value)
    new_node = Node.new(value)
    @head ||= new_node
    @tail.next_node = new_node if @tail
    @tail = new_node
  end

  def prepend(value)
    new_node = Node.new(value, @head)
    @head = new_node
    @tail ||= new_node
  end

  def size
    number = 0
    cur_node = @head
    until cur_node.nil?
      number += 1
      cur_node = cur_node.next_node
    end
    number
  end

  def at(index)
    return 'error - no node at given index' if index >= self.size || index.negative?

    node_number = 0
    cur_node = @head
    until node_number == index
      node_number += 1
      cur_node = cur_node.next_node
    end
    cur_node
  end

  def pop
    return 'error - list already empty' if self.size.zero?

    if self.size == 1
      @head = nil
      return
    end
    prev_node = @head
    cur_node = prev_node.next_node
    until cur_node.next_node.nil?
      prev_node = cur_node
      cur_node = cur_node.next_node
    end
    prev_node.next_node = nil
    @tail = prev_node
  end

  def contains?(value)
    cur_node = @head
    until cur_node.nil?
      return true if cur_node.value == value

      cur_node = cur_node.next_node
    end
    false
  end

  def find(value)
    cur_node = @head
    node_index = 0
    until cur_node.nil?
      return node_index if cur_node.value == value

      cur_node = cur_node.next_node
      node_index += 1
    end
    nil
  end

  def to_s
    return 'list is empty' if self.size.zero?

    cur_node = @head
    until cur_node.nil?
      print "( #{cur_node.value} ) -> "
      cur_node = cur_node.next_node
    end
    puts 'nil'
  end

  def insert_at(value, index)
    return prepend(value) if index.zero? || index < -self.size

    return append(value) if index >= self.size || index == -1

    new_node = Node.new(value)
    if index.positive?
      number = 1
      prev_node = @head
      cur_node = prev_node.next_node
      until number == index
        prev_node = cur_node
        cur_node = cur_node.next_node
        number += 1
      end
      new_node.next_node = cur_node
      prev_node.next_node = new_node
    end
    if index.negative?
      number = 1
      prev_node = @head
      cur_node = prev_node.next_node
      until (number - self.size - 1) == index
        prev_node = cur_node
        cur_node = cur_node.next_node
        number += 1
      end
      new_node.next_node = cur_node
      prev_node.next_node = new_node
    end
  end

  def remove_at(index)
    return 'error - list already empty' if self.size.zero?

    return 'error - no node at given index' if index >= self.size || index < -self.size

    return pop if index == -1 || index == self.size - 1

    return @head = @head.next_node if index.zero? || index == -self.size

    prev_node = @head
    cur_node = prev_node.next_node
    number = 1
    until number == index
      prev_node = cur_node
      cur_node = cur_node.next_node
      number += 1
    end
    prev_node.next_node = cur_node.next_node
  end
end

list = LinkedList.new
list.prepend("hi")
list.append("hello")
p list.size