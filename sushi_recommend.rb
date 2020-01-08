require "./lib/file_util.rb"
require "./lib/array_util.rb"

def generate_preference_from(params) # params={"ika"=>1,"tako"=>3,...} length>=10
	preference_base = [-1]*100
	name_idx_map = get_sushi_hash_from("./data/sushi_ids.txt")
	hash = params.map{|k,v| k=name_idx_map[k],v=v}.to_h
	hash.each do |k,v|
		preference_base[k] = v
	end
	preference_base.map(&:to_f)
end

def exclude_some_not_having_similar_preferences(given_prf,preferences)
	# 共通の評価が少なく他がすべて欠損値(-1)とき、
	#それが一致すると相関係数が極端に高くなってしまうので、
	# 欠損値以外で共通のものを評価している人を抽出する 

	thresold = 3
	comparable_prfs=[]
	# 欠損値が-1なので、おなじindexの要素に１を足しをかけ合わせた結果が0にならないものが
	# 一定数以上あれば、その２人は共通の寿司ネタを評価していると考えられる
	preferences.each do |prf|
		if (prf.zip(given_prf).
			map{|p_v,g_v|(p_v+1.0)*(g_v+1.0)}-[0.0]).
			length > thresold
			
			comparable_prfs << prf
		end
	end
	comparable_prfs
end

def get_similarities(given_prf,comparable_prfs)
	
	similarities = []

	comparable_prfs.each.with_index do |prf,c_idx|
		similarities << [c_idx,prf.r(given_prf)]
		# comparale_prefsのc_idx番目との相関係数
	end
	similarities.sort{|l,r| r[1]<=>l[1]}
end

def ranking(gvn_pref,comparable_prfs,similarities)
	ranking=[]
	for item_idx in 0..99 do
		next if gvn_pref[item_idx]>=0
		 ranking << [item_idx, gvn_pref.mean + similarities.inject(0){
				 |sigma,sim| sigma += sim[1]*(
					 comparable_prfs[sim[0]].nth_dev(item_idx)
					)
				}/similarities.inject(0){|s,a| s+=a[1]}.to_f] 
	end
	ranking.sort{|l,r| r[1]<=>l[1]}
end
				

def get_ranking_by(preference)
	the_other_preferences =  get_preferences_data_from("./data/sushi3b.5000.10.score")
	comparable_preferences = exclude_some_not_having_similar_preferences(
		preference,
		the_other_preferences
	)
	similarities = get_similarities(preference,comparable_preferences)
	result = ranking(
		preference,
		comparable_preferences,
		similarities
	)
	idx_name_map = get_sushi_hash_from("./data/sushi_ids.txt").invert
	result.map{|l,r|
		l=idx_name_map[l],r=r
	}
end


			   



			



			
