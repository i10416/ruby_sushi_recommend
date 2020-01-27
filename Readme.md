# 概要
Sinatraを使って作ったAPIサーバー. いくつかの寿司の評価をJSON形式でPOSTするとおすすめの寿司ネタをレコメンドする.

# 目的
Python以外でデータサイエンスをやったことが無かったので練習のため実装した.

# 機能

寿司の名前と評価(0～4)をPOSTすると、おススメのすしネタをレコメンドするAPIサーバー

Request

```
curl http://localhost:4567/api/v1/ -X POST -H "Content-Type: application/json" -d '{"ika":1,"tako":2,"tarako":3,"sanma":2,"ankimo":1,"fugu":4,"okura":2,"buri":3,"zuke":1,"kue":3}'
```

Response

```
{
  "best":[
    "ebi",
    0.977910028....
  ],
  "second_best":[
    "maguro",
    0.311296889.... 
  ],
  "third_best":[
    "tamago",
    0.096895910...
  ]
}

```

# 技術
Ruby, Sinatra
