require "csv" 

def create_new_memo
  puts "メモのファイル名を入力してください（拡張子は不要）。"
  file_name = STDIN.gets.chomp + ".csv"
  
  puts "メモの内容を入力してください。終了するには、Ctrl + Dを押してください。"
  memo = STDIN.read.chomp

  CSV.open(file_name, "a") do |csv|
    memo.each_line do |line|
      csv << [line.chomp]
    end
  end
  puts "メモを追加しました。"
end

def show_memo(file_name)
  if File.exist?(file_name)
    puts "----- メモ一覧 -----"
    CSV.foreach(file_name) do |row|
      puts row[0]
    end
    puts "--------------------"
  else
    puts "メモはありません。"
  end
end

def edit_existing_memo(file_name)
  if !File.exist?(file_name)
    puts "メモがありません。"
    return
  end

  data = CSV.read(file_name)
  puts "現在のデータ:"
  data.each_with_index { |row, index| puts "#{index + 1}. #{row.join(', ')}" }

  puts "編集する行の番号を入力してください。"
  row_indices = STDIN.gets.chomp.split(',').map(&:to_i)

  new_data = []
  row_indices.each do |index|
    puts "新しいデータを入力してください。現在のデータは以下の通りです。"
    puts data[index - 1][0]
    new_data << STDIN.gets.chomp
  end

  row_indices.each_with_index do |index, i|
    data[index - 1] = [new_data[i]]
  end

  CSV.open(file_name, "w") do |csv|
    data.each { |row| csv << row }
  end

  puts "メモを編集しました。"
end

puts "1(新規でメモを作成) 2(既存のメモを表示する) 3(既存のメモを編集する)"
memo_type = STDIN.gets.to_i

case memo_type
when 1
  create_new_memo
when 2
  puts "表示するメモのファイル名を入力してください（拡張子は不要）。"
  file_name = STDIN.gets.chomp + ".csv"
  show_memo(file_name)
when 3
  puts "編集するメモのファイル名を入力してください（拡張子は不要）。"
  file_name = STDIN.gets.chomp + ".csv"
  edit_existing_memo(file_name)
else
  puts "不正な値です"
end

loop do
  puts "1. メモを追加する"
  puts "2. メモを表示する"
  puts "3. メモを編集する"
  puts "4. 終了する"
  print "選択してください: "
  choice = STDIN.gets.chomp.to_i

  case choice
  when 1
    create_new_memo 
  when 2
    puts "表示するメモのファイル名を入力してください（拡張子は不要）。"
    file_name = STDIN.gets.chomp + ".csv"
    show_memo(file_name)
  when 3
    puts "編集するメモのファイル名を入力してください（拡張子は不要）。"
    file_name = STDIN.gets.chomp + ".csv"
    edit_existing_memo(file_name)
  when 4
    puts "アプリを終了します。"
    break
  else
    puts "無効な選択です。"
  end
end



