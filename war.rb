puts '戦争を開始します'
class Card
  def initialize
    # カードのランクを定義
    @card_ranks = {
      'A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, '10' => 10, '9' => 9,
      '8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2,
    }
  end

  # デッキを作成するメソッドを作成
  def deck_creation
    # card_typesを作成しそれぞれのタイプを配列に追加
    card_types = ['ダイヤ', 'ハート', 'スペード', 'クローバー']

    # @card_ranksインスタンス変数を.keysで配列を全て取得
    ranks = @card_ranks.keys

    # prodcutメソッドをmapメソッドを使用し、ranksとcard_typesを組み合わせた新たな配列の作成
    deck = ranks.product(card_types).map do |rank, type|
      [rank, type]
    end

    # deckの配列をshuffleメソッドを使用し、シャッフル
    deck.shuffle
  end

  # deck_creationメソッドのdeckを配るメソッドの作成
  def deck_deal(deck)
    # deckを二つに分ける
    [deck[0..25], deck[26..51]]
  end

  # カードの強さを比較するメソッドを作成
  def card_strength(card1, card2)
    # カードのランクを取得する
    rank1 = card1[0]
    rank2 = card2[0]

    # 条件分岐を使ってカードの強さを比較する
    # カード1が強い場合
    if @card_ranks[rank1] > @card_ranks[rank2]
      card1
    # カード2が強い場合
    elsif @card_ranks[rank1] < @card_ranks[rank2]
      card2
    # 引き分けの場合
    else
      nil
    end
  end
end

class Player
  # プレイヤーの名前と手札を作成
  def initialize(name, hand)
    @name = name
    @hand = hand
  end

  # 名前を取得するメソッド
  def get_name
    @name
  end

  # 手札の枚数を把握するメソッド
  def count_card
    # lengthメソッドを使い配列を展開
    @hand.length
  end

  # 手札からカードを出すメソッド
  def play_card
    # 最初のカードを取り出す
    @hand.shift
  end

  # 勝ったらカードをもらうメソッド
  def get_cards(cards)
    # concatメソッドを使って配列の結合
    @hand.concat(cards)
  end

  # 手札を持っているかどうかのメソッド
  def has_cards?
    # lengthメソッドを使い配列を展開
    @hand.length > 0
  end
end

player = Player.new("Alice", ["3H", "5D", "10S"])

# 名前を取得
puts player.get_name

# カードを数える
puts player.count_card

# カードをプレイする
puts player.play_card

# カードを追加する
puts player.get_cards(["8C", "9D"])

# カードが残っているか確認
puts player.has_cards?
