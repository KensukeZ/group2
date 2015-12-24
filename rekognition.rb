file = File.open("log.txt","r")
file.each_line do |line|
	arr = line.split("},")			#テキストを配列に分割
	i = 0
	z = 0
	maxname = []
	maxnamenumber = []
	maxemotion = []
	maxemotionnumber = []
	while arr[i]
		if arr[i].index(":")		#名前と値を取り出す
			/:/ =~ arr[i]
			maxname[i] = $`
			maxnamenumber[i] = $'
		end
		if arr[i].index("name\"=>\"")		#名前の不要な部分を取り除く
			/name\"=>\"/ =~ maxname[i]
			maxname[i] = $'
		end
		if arr[i].index("emotion\"=>")
			arr2 = arr[i].split(", ")	#emotion部分の分割
			while arr2[z]
				if arr2[z].index("\"=>")	#emotionの種類と値を取り出す
					/\"=>/ =~ arr2[z]
					maxemotion[z] = $`
					maxemotionnumber[z] = $'
				end
				if maxemotionnumber[z].index("\"=>")	#初めの部分をさらに分割
					/\"=>/ =~ maxemotionnumber[z]
					maxemotion[z] = $`
					maxemotionnumber[z] = $'
				end
				if maxemotion[z].index("")		#名前の不要な部分を取り除く
					/"/ =~ maxemotion[z]
					maxemotion[z] = $'
				end
				z += 1
			end
		end
		i += 1
	end

	maxENumber = 0.0
	maxEmotion = "a"
	maxNumber = 0.0
	maxName = "a"
	maxNnumber = []
	maxEnumber = []

	for j in 0..i do				#numberを文字列から数値に変換
		maxNnumber[j] = maxnamenumber[j].to_f
		maxEnumber[j] = maxemotionnumber[j].to_f
	end
	
	s = 100
	t = 100
	for k in 0..i do				#name, emotionの最大値を検出
		if maxNnumber[k] > maxNumber && maxNnumber[k] > 0.0
			maxNumber = maxNnumber[k]
			s = k
		end
		if maxEnumber[k] > maxENumber && maxEnumber[k] > 0.0
			maxENumber = maxEnumber[k]
			t = k
		end
	end
	
	maxName = maxname[s]				#最大値に対応したname
	maxEmotion = maxemotion[t]			#最大値に対応したemotion
	if maxName					#名前が登録されていたら表示
		puts "-------------------------------------------"
		puts maxName
		puts maxNumber
		puts maxEmotion
		puts maxENumber
		puts "-------------------------------------------"
	end
end

file.close