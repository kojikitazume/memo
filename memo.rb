require "csv" 

def create_new_memo
  puts "メモの内容を入力してください:"
  memo = gets.chomp
  CSV.open("memos.csv", "a") do |csv|
    csv << [memo]
  end
  puts "メモを追加しました。"
end

def show_memo
  if File.exist?("memos.csv")
    puts "----- メモ一覧 -----"
    CSV.foreach("memos.csv") do |row|
      puts row[0]
    end
    puts "--------------------"
  else
    puts "メモはありません。"
  end
end

def edit_existing_memo
  data = CSV.read("memos.csv")
  puts "現在のデータ:"
  data.each { |row| puts row.join(', ') }

  puts "編集する行の番号を入力してください:"
  row_index = gets.chomp.to_i - 1

  puts "新しいデータを入力してください:"
  new_data = gets.chomp.split(',')
  data[row_index] = new_data

  CSV.open("memos.csv", "w") do |csv|
    data.each { |row| csv << row }
  end
end

puts "1(新規でメモを作成) 2(既存のメモを表示する) 3(既存のメモを編集する)"
memo_type = gets.to_i

if memo_type == 1
  create_new_memo
elsif memo_type == 2
  show_memo
elsif memo_type == 3
  edit_existing_memo
else
  puts "不正な値です"
end

loop do
    puts "1. メモを追加する"
    puts "2. メモを表示する"
    puts "3. メモを編集する"
    puts "4. 終了する"
    print "選択してください: "
    choice = gets.chomp.to_i
  
    case choice
    when 1
      create_new_memo 
    when 2
      show_memo
    when 3
      edit_existing_memo
    when 4
        puts "アプリを終了します。"
      break
    else
      puts "無効な選択です。"
    end
  end

