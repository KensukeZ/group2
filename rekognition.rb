file = File.open("log.txt","r")
file.each_line do |line|
	arr = line.split("},")			#�e�L�X�g��z��ɕ���
	i = 0
	z = 0
	maxname = []
	maxnamenumber = []
	maxemotion = []
	maxemotionnumber = []
	while arr[i]
		if arr[i].index(":")		#���O�ƒl�����o��
			/:/ =~ arr[i]
			maxname[i] = $`
			maxnamenumber[i] = $'
		end
		if arr[i].index("name\"=>\"")		#���O�̕s�v�ȕ�������菜��
			/name\"=>\"/ =~ maxname[i]
			maxname[i] = $'
		end
		if arr[i].index("emotion\"=>")
			arr2 = arr[i].split(", ")	#emotion�����̕���
			while arr2[z]
				if arr2[z].index("\"=>")	#emotion�̎�ނƒl�����o��
					/\"=>/ =~ arr2[z]
					maxemotion[z] = $`
					maxemotionnumber[z] = $'
				end
				if maxemotionnumber[z].index("\"=>")	#���߂̕���������ɕ���
					/\"=>/ =~ maxemotionnumber[z]
					maxemotion[z] = $`
					maxemotionnumber[z] = $'
				end
				if maxemotion[z].index("")		#���O�̕s�v�ȕ�������菜��
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

	for j in 0..i do				#number�𕶎��񂩂琔�l�ɕϊ�
		maxNnumber[j] = maxnamenumber[j].to_f
		maxEnumber[j] = maxemotionnumber[j].to_f
	end
	
	s = 100
	t = 100
	for k in 0..i do				#name, emotion�̍ő�l�����o
		if maxNnumber[k] > maxNumber && maxNnumber[k] > 0.0
			maxNumber = maxNnumber[k]
			s = k
		end
		if maxEnumber[k] > maxENumber && maxEnumber[k] > 0.0
			maxENumber = maxEnumber[k]
			t = k
		end
	end
	
	maxName = maxname[s]				#�ő�l�ɑΉ�����name
	maxEmotion = maxemotion[t]			#�ő�l�ɑΉ�����emotion
	if maxName					#���O���o�^����Ă�����\��
		puts "-------------------------------------------"
		puts maxName
		puts maxNumber
		puts maxEmotion
		puts maxENumber
		puts "-------------------------------------------"
	end
end

file.close