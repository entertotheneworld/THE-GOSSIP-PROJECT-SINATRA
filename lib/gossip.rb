require 'csv'

class Gossip 
  attr_reader :author, :content

  def initialize(author, content)
    @author = author
    @content = content
  end

  # SAVE GOSSIP
  def save
    CSV.open("./db/gossip.csv", "ab") do |csv|
      csv << [@author, @content]
    end
  end

  # VIEW ALL GOSSIP
  def self.all
    all_gossips = []
    CSV.read("./db/gossip.csv").each do |csv_line|
      all_gossips << Gossip.new(csv_line[0], csv_line[1])
    end
    return all_gossips
  end

  # FIND GOSSIP
  def self.find(id)
    Gossip.all.each_with_index {|row, i|
      return row if i + 1 == id.to_i
    }
  end

  # EDIT GOSSIP
  def self.edit(author, content, id)
    rows_array = []
    CSV.read('./db/gossip.csv').each_with_index do |csv_line, i|
      (i + 1 == id.to_i) ? (rows_array << Gossip.new(author, content)) : (rows_array << Gossip.new(csv_line[0], csv_line[1]))
    end
    CSV.open("./db/gossip.csv", "w")
    rows_array.each{|row| row.save}
  end

end