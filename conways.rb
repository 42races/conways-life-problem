#!/usr/bin/env ruby

require 'matrix'

class ConwayMap
  def initialize()
    @map = Matrix[[0,0,0,0,0], [0,0,0,0,0], [0,1,1,1,0],[0,0,0,0,0], [0,0,0,0,0]]
    die_list = []
    alive_list = []
  end

  def get_live_neighbours(i,j)
    neighbours = []
    adj = [[i-1,j-1], [i-1,j], [i-1,j+1],[i,j-1], [i,j+1], [i+1,j-1], [i+1,j],[i+1,j+1]]
    adj.each do |i, j|
      neighbours<< [i, j] if(@map[i,j] && ((i >= 0) && (j >= 0)) && (@map[i, j] == 1))
    end
    neighbours
  end

  def die(i,j)
    temp = *@map
    temp[i][j] = 0
    @map = Matrix[*temp]
  end

  def live(i,j)
    temp = *@map
    temp[i][j] = 1
    @map = Matrix[*temp]
  end

  def alive?(row, column)
    @map[row,column] == 1
  end

  def dead?(row, column)
    @map[row,column] == 0
  end

  def print_map
    @map.each_with_index do |elem, row, column|
      c = (elem == 0) ? "0" : "*"
	print " #{c} "
      	print "\n" if(column == 4)
    end
    puts "\nnext"
  end

  def tick
    @die_list = []
    @live_list = []

    @map.each_with_index do |elem, row, column|
      neighbours = get_live_neighbours(row, column)
      count = neighbours.count
      if(count < 2 || count > 3)
        @die_list<< [row,column] if alive?(row, column)
      elsif(count == 3)
        @live_list<< [row, column] if dead?(row, column)
      else
      end
    end

    @die_list.each { |i,j| die(i,j)}
    @live_list.each { |i,j| live(i,j)}
  end
end

map = ConwayMap.new

loop do
  map.print_map()
  map.tick()
  sleep(2)
end
