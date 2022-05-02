require 'csv'

class Gossip 
  attr_reader :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  def self.find(id)
    Gossip.all.each_with_index {|row, i|
      return row if i + 1 == id.to_i
    }
  end

  def self.edit(author, content, id)
    rows_array = []
    CSV.read('./db/gossip.csv').each_with_index do |csv_line, i|
      if i + 1 == id.to_i
         # modify over here
         rows_array << Gossip.new(author, content)
      else 
        rows_array << Gossip.new(csv_line[0], csv_line[1])
      end
    end
    CSV.open("./db/gossip.csv", "w")
    rows_array.each{|row| row.save}
  end


end