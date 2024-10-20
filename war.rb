puts '戦争を開始します'
class CARD
  def initialize
    # カードのランクを定義
    @card_ranks = {'A' => 14, 'K' => 13, 'Q' => 12, 'J' => 11, '10' => 10, '9' => 9, '8' => 8, '7' => 7, '6' => 6, '5' => 5, '4' => 4, '3' => 3, '2' => 2}
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
    if @card_ranks[rank1] > @card_ranks[rank2]
      puts "カード1 (#{card1[1]}の#{rank1}) の勝利"
    elsif @card_ranks[rank1] < @card_ranks[rank2]
      puts "カード2 (#{card2[1]}の#{rank2}) の勝利"
    else
      '引き分け'
    end
  end
end

# CARDクラスのインスタンスを生成
created_card = CARD.new

# deck_creationでデッキを作成し、それを変数に渡す
deck = created_card.deck_creation

# カードの強さを比較
hands = created_card.deck_deal(deck)
card1 = hands[0][0]
card2 = hands[1][0]
created_card.card_strength(card1, card2)
